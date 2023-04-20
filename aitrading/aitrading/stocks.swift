import SwiftUI
import Foundation

struct StockQuote: Codable {
    let symbol: String
    let regularMarketPrice: Double
    let regularMarketChangePercent: Double?
}

class StockFetcher: ObservableObject {
    @Published var quotes = [StockQuote]()
    
    func fetchQuotes(symbols: [String]) {
        let symbolString = symbols.joined(separator: ",")
        let urlString = "https://query1.finance.yahoo.com/v7/finance/quote?symbols=\(symbolString)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try decoder.decode(StockResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.quotes = response.quoteResponse.result
                        for quote in self.quotes {
                            let predictedViewModel = PredictedPriceChartViewModel(symbol: quote.symbol)
                            self.predictedViewModels[quote.symbol] = predictedViewModel
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    var predictedViewModels: [String: PredictedPriceChartViewModel] = [:]
}

struct StockResponse: Codable {
    let quoteResponse: QuoteResponse
}

struct QuoteResponse: Codable {
    let result: [StockQuote]
}

struct PredictedViewModelsEnvironmentKey: EnvironmentKey {
    static var defaultValue: [String: PredictedPriceChartViewModel] = [:]
}

extension EnvironmentValues {
    var predictedViewModels: [String: PredictedPriceChartViewModel] {
        get { self[PredictedViewModelsEnvironmentKey.self] }
        set { self[PredictedViewModelsEnvironmentKey.self] = newValue }
    }
}

struct stocks: View {
    let symbols: [String]
    @ObservedObject var stockFetcher = StockFetcher()
    @State var viewModels: [String: StockChartViewModel] = [:]
    
    var body: some View {
        List {
            ForEach(stockFetcher.quotes, id: \.symbol) { quote in
                if let viewModel = viewModels[quote.symbol] {
                    StockView(quote: quote, viewModel: viewModel)
                } else {
                    let viewModel = StockChartViewModel(symbol: quote.symbol)
                    StockView(quote: quote, viewModel: viewModel)
                        .onAppear {
                            viewModels[quote.symbol] = viewModel
                        }
                }
            }
            .listRowBackground(Color.black)
        }
        .listStyle(PlainListStyle())
        .onAppear {
            stockFetcher.fetchQuotes(symbols: symbols)
        }
        .environment(\.predictedViewModels, stockFetcher.predictedViewModels)
    }
    
}


struct StockView: View {
    let quote: StockQuote
    let ticker: String
    @ObservedObject var viewModel: StockChartViewModel
    @State private var selectedStock: StockQuote?
    @State private var isSheetPresented = false
    
    @Environment(\.predictedViewModels) private var predictedViewModels
    
    init(quote: StockQuote, viewModel: StockChartViewModel) {
        self.quote = quote
        self.ticker = quote.symbol
        self.viewModel = viewModel
    }

    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "https://logo.clearbit.com/\(ticker.lowercased()).com")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
            .frame(width: 90, height: 30)
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .padding(.all, 4)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(quote.symbol)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                Text(String(format: "%.2f", quote.regularMarketPrice))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if let changePercent = quote.regularMarketChangePercent {
                    Text(String(format: "%.2f%%", changePercent))
                        .font(.caption)
                        .foregroundColor(changePercent < 0 ? .red : .green)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Button(action: {
                viewModel.symbol = quote.symbol
                isSheetPresented.toggle()
            }) {
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $isSheetPresented) {
            VStack {
                chartView(symbol: quote.symbol, viewModel: viewModel)
                    .onAppear {
                        viewModel.symbol = quote.symbol
                    }
                if let predictedViewModel = predictedViewModels[quote.symbol] {
                    Divider()
                    PredictedPriceChartView(viewModel: predictedViewModel)
                }
                Spacer()
            }
            .background(Color.black)
        }
    }
}





struct stocks_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            stocks(symbols: ["TSLA"])
        }
    }
}
