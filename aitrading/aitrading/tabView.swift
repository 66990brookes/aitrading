import SwiftUI

struct tabView: View {
    @State private var selectedTab = 0
    let symbols = [["AAPL", "TSLA", "AMZN"], ["MSFT", "GOOG", "FB"]]
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text("Stocks").tag(0)
                Text("Watchlist").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if selectedTab == 0 {
                stocks(symbols: symbols[0])
            } else {
                stocks(symbols: symbols[1])
            }
        }
    }
}



struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView()
    }
}
