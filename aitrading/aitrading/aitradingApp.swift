//
//  aitradingApp.swift
//  aitrading
//
//  Created by Gerald Simon on 28/03/23.
//

import SwiftUI
import Firebase
import SwiftYFinance
@main
struct aitradingApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
