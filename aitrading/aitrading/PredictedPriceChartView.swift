import SwiftUI
import SwiftUICharts

struct PredictedPriceChartView: View {
    @ObservedObject var viewModel: PredictedPriceChartViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Predicted Prices")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 8)

            if !viewModel.dataPoints.isEmpty {
                LineView(data: viewModel.dataPoints, title: "", legend: "", valueSpecifier: "%.2f")
                    .frame(height: 200)
            } else {
                Text("No data available")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
