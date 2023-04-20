//
//  menuScreen.swift
//  aitrading
//
//  Created by Gerald Simon on 28/03/23.
//

import SwiftUI

struct menuScreen: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
            ZStack{
                Color(.black)
                    .frame(height: 900)
                Text("Settings")
                    .foregroundColor(.gray)
                    .offset(y:-350)
                    .font(.title2)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
                .padding(.leading, 20)
                .frame(width: 50, height: 50)
                .offset(x: -145, y: -345)
                Spacer()
                VStack{
                    Button{
                        //
                    }label: {
                        Text(" Account details")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .offset(y:50)
                    
                    Button{
                        //
                    }label: {
                        Text(" Account security")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:25)
                    
                    Button{
                        //
                    }label: {
                        Text(" Trading prefrences")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:0)
                    
                    Button{
                        //
                    }label: {
                        Text(" Language")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:-25)
                    
                    Button{
                        //
                    }label: {
                        Text(" Notifications")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:-50)
                    
                    Button{
                        //
                    }label: {
                        Text(" History")
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:-75)
                    
                    Button{
                        //
                    }label: {
                        Text(" Log out")
                            .padding(.leading)
                            .foregroundColor(.red)
                            .frame(width: 400, height: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .opacity(0.04))
                        
                    }
                    .padding(.top)
                    .offset(y:-100)
                }
                NavigationLink(destination: homeScreen(), label: {
                                EmptyView()
                            })
            }
        }
    }

    

struct menuScreen_Previews: PreviewProvider {
    static var previews: some View {
        menuScreen()
    }
}
