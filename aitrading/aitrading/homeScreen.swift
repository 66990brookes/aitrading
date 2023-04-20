//
//  homeScreen.swift
//  aitrading
//
//  Created by Gerald Simon on 28/03/23.
//

import SwiftUI

struct homeScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab = 0
    @State private var searchStock: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    homeTop(searchIt: $searchStock)
                    
                    portfolio()
                    
                    tabView()
    
                    
                    tabBar()
                }
            }
            .sheet(isPresented: $searchStock){
                Text("search")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct TabBarButton: View {
    
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 20, weight: isSelected ? .bold : .regular))
                    .scaleEffect(isSelected ? 1.2 : 1.0)
            }
            .foregroundColor(isSelected ? .white : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

struct homeScreen_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
    }
}
