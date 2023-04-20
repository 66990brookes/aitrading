//
//  searchScreen.swift
//  aitrading
//
//  Created by Gerald Simon on 28/03/23.
//

import SwiftUI

struct searchScreen: View {
    @State var search = ""
    var body: some View {
        NavigationView{
            
            ZStack{
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    TextField("Search", text: $search)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: search.isEmpty){
                            Text("search")
                                .foregroundColor(.white)
                        }
                        .offset(y:-300)
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                        .offset(y: -300)
                }
                .frame(width: 350)
            }.ignoresSafeArea()
        }
    }
}

struct searchScreen_Previews: PreviewProvider {
    static var previews: some View {
        searchScreen()
    }
}
