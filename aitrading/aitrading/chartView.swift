import SwiftUI
import Combine
import Foundation
import Charts

class StockChartViewModel: ObservableObject {
    var symbol: String
    
    @Published var chartData: [Double] = []
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var currentPrice: Double = 0
    @Published var previousClosePrice: Double = 0
    
    private var cancellable: AnyCancellable?
    
    init(symbol: String) {
        self.symbol = symbol
    }
    enum TimePeriod: String, CaseIterable {
        case day = "1D"
        case week = "1W"
        case month = "1M"
        case sixMonths = "6M"
        
        var range: String {
            switch self {
            case .day:
                return "1d"
            case .week:
                return "1wk"
            case .month:
                return "1mo"
            case .sixMonths:
                return "6mo"
            }
        }
    }

    func fetchData(for timePeriod: TimePeriod) {
        isLoading = true

        let timePeriodRange = timePeriod.range
        let urlString = "https://query1.finance.yahoo.com/v8/finance/chart/\(symbol)?range=\(timePeriodRange)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ChartResponse.self, decoder: JSONDecoder())
            .map { $0.chart.result.first?.indicators.quote.first?.close ?? [] }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                self?.isLoading = false
                self?.chartData = data

                if let currentPrice = data.last {
                    self?.currentPrice = currentPrice
                }

                if let previousClosePrice = data.dropLast().last {
                    self?.previousClosePrice = previousClosePrice
                }
            })
    }


    
    var changeIconName: String {
        if self.currentPrice > self.previousClosePrice {
            return "arrow.up.right.square.fill"
        } else if self.currentPrice < self.previousClosePrice {
            return "arrow.down.right.square.fill"
        } else {
            return "minus.square.fill"
        }
    }
    
    var changePercentage: Double {
        if currentPrice != 0 && previousClosePrice != 0 {
            return ((currentPrice - previousClosePrice) / currentPrice) * 100
        } else {
            return 0
        }
    }
}



struct ChartResponse: Codable {
    let chart: Chart
}

struct Chart: Codable {
    let result: [ChartResult]
}

struct ChartResult: Codable {
    let indicators: ChartIndicators
}

struct ChartIndicators: Codable {
    let quote: [ChartQuote]
}

struct ChartQuote: Codable {
    let close: [Double]?
}

struct chartView: View {
    let symbol: String
    @ObservedObject var viewModel: StockChartViewModel
    
    @State private var timePeriodSelection = 0
    
    private let timePeriods = StockChartViewModel.TimePeriod.allCases
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $timePeriodSelection, label: Text("Timeframe")) {
                ForEach(timePeriods.indices, id: \.self) { index in
                    Text(self.timePeriods[index].rawValue).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            .foregroundColor(.black)
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
            } else {
                VStack(alignment: .leading) {
                    LineChartView(dataPoints: viewModel.chartData)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .padding()
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(viewModel.symbol)
                                .font(.title)
                                .foregroundColor(.white)
                            Text("\(viewModel.currentPrice, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("\(viewModel.changePercentage, specifier: "%.2f") (\(viewModel.changePercentage, specifier: "%.2f")%)")
                                .font(.subheadline)
                                .foregroundColor(viewModel.changePercentage > 0 ? .green : .red)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchData(for: timePeriods[timePeriodSelection])
        }
        .onChange(of: timePeriodSelection) { newValue in
            viewModel.fetchData(for: timePeriods[newValue])
        }
    }
}

    
    
    
    struct LineChartView: View {
        let dataPoints: [Double]
        let maxYValue: Double
        let minYValue: Double
        
        init(dataPoints: [Double], maxYValue: Double? = nil, minYValue: Double? = nil) {
            self.dataPoints = dataPoints
            self.maxYValue = maxYValue ?? dataPoints.max() ?? 0
            self.minYValue = minYValue ?? dataPoints.min() ?? 0
        }
        
        var body: some View {
            GeometryReader { geometry in
                let chartHeight = geometry.size.height * 0.7
                let chartWidth = geometry.size.width
                
                Path { path in
                    let xScale = chartWidth / CGFloat(dataPoints.count - 1)
                    let yScale = chartHeight / CGFloat(maxYValue - minYValue)
                    
                    path.move(to: CGPoint(x: 0, y: chartHeight - CGFloat(dataPoints.first ?? 0) * yScale))
                    
                    for index in dataPoints.indices {
                        let point = CGPoint(x: CGFloat(index) * xScale, y: chartHeight - CGFloat(dataPoints[index] - minYValue) * yScale)
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.blue, lineWidth: 2)
                
                // Add x-axis labels
                HStack(spacing: 0) {
                    ForEach(dataPoints.indices, id: \.self) { index in
                        Text("\(index)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(width: chartWidth / CGFloat(dataPoints.count) - 1, height: 20)
                    }
                }
                .frame(height: geometry.size.height * 0.3)
//                .animation(.default)
            }
        }
    }
    
    
//    struct chartView_Previews: PreviewProvider {
//        static var previews: some View {
//            chartView(symbol: "AAPL", viewModel: StockChartViewModel(symbol: "AAPL"))
//        }
//    }
