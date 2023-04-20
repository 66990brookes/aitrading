import SwiftUI
import SwiftUICharts

struct LineChartSwiftUI: View {
    var predictedData: [Double]

    var body: some View {
        LineView(data: predictedData, title: "", legend: "")
    }
}
