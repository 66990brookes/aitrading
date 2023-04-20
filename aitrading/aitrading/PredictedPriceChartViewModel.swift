import Foundation
import Firebase
import FirebaseDatabase

class PredictedPriceChartViewModel: ObservableObject {
    @Published var dataPoints: [Double] = []
    private let stockDataRef = Database.database().reference().child("stocks")
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
        fetchStockData { error in
            if let error = error {
                print("Error fetching stock data: \(error)")
            } else {
                print("Stock data fetched successfully")
            }
        }
    }
    
    func fetchStockData(completion: @escaping (Error?) -> Void) {
        print("Fetching stock data for symbol: \(symbol)")
        stockDataRef.child(symbol).observeSingleEvent(of: .value, with: { snapshot in
            print("Stock data snapshot: \(snapshot)")
            guard let dataDict = snapshot.value as? [String: Any],
                  let predictedData = dataDict["predicted"] as? [[String: Any]] else {
                      completion(nil)
                      return
            }
            self.dataPoints = predictedData.compactMap { $0["yhat"] as? Double }
            print("Predicted data points for symbol \(self.symbol): \(self.dataPoints)")
            completion(nil)
        }, withCancel: { error in
            print("Error fetching stock data for symbol \(self.symbol): \(error)")
            completion(error)
        })
    }



}

struct PredictedPriceResponse: Codable {
    let predictions: [Double]
}
