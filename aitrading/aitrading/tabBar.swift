//
//  tabBar.swift
//  aitrading
//
//  Created by Gerald Simon on 30/03/23.
//

import SwiftUI

struct tabBar: View {
    @State private var selectedTab = 0
    var body: some View {
        switch selectedTab {
        case 0:
//            homeScreen()
            Text("")
        case 1:
            Text("")
        case 2:
            Text("")
        case 3:
            Text("")
        case 4:
            menuScreen()
        default:
            Text("")
        }

            HStack {
                TabBarButton(imageName: "house.fill", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                Spacer()
                TabBarButton(imageName: "magnifyingglass", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                Spacer()
                TabBarButton(imageName: "chart.pie", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                Spacer()
                TabBarButton(imageName: "bell", isSelected: selectedTab == 3){
                    selectedTab = 3
                }
                Spacer()
                TabBarButton(imageName: "list.dash",isSelected: selectedTab == 4){
                    selectedTab = 4
                }
            }
            .background(Color.black)
            .padding(.horizontal, 20)
    }
}

struct tabBar_Previews: PreviewProvider {
    static var previews: some View {
        tabBar()
    }
}
