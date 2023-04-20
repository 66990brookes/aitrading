//
//  homeTop.swift
//  aitrading
//
//  Created by Gerald Simon on 29/03/23.
//

import SwiftUI

struct homeTop: View {
    @Binding var searchIt: Bool
    var body: some View {
                    
            HStack{
                Button{
                    //
                }label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .imageScale(.large)
                        .foregroundColor(.blue)
                        .frame(width: 40, height: 40)
                }
                .padding()
                Spacer()
                
                Button(action:  {
                    searchIt.toggle()
                }){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                }
                .padding()

            }
            
        }
}

//struct homeTop_Previews: PreviewProvider {
//    static var previews: some View {
//        homeTop()
//    }
//}
