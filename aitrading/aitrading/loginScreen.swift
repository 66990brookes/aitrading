//
//  loginScreen.swift
//  aitrading
//
//  Created by Gerald Simon on 28/03/23.
//

import SwiftUI
import Firebase

struct loginScreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var userLoggedIn = false
    var body: some View {
        if userLoggedIn{

        }else{
            content
        }
    }
    var content: some View{
        ZStack{
          Color(hue: 0.573, saturation: 0.99, brightness: 0.253)
            VStack(spacing: 20){
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x:0, y:-60)
                TextField("Username", text: $username)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: username.isEmpty){
                        Text("Username")
                            .foregroundColor(.white)
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty){
                        Text("Password")
                            .foregroundColor(.white)
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
            
                Button{
                    login()
                } label: {
                    Text("Login")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors:[.blue, .blue], startPoint: .top, endPoint: .bottomTrailing)))
                }
                .padding(.top)
                .offset(y:30)
                .onAppear {
                    Auth.auth().addStateDidChangeListener{
                        auth, user in if user != nil{
                            userLoggedIn.toggle()
                        }
                    }
                }
                
                Button{
                    register()
                } label: {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:40)

                Button{
                    
                } label: {
                    Text("Forgot username or password ?")
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:20)

            }.frame(width: 350)
        }
        .ignoresSafeArea()
    }
    func register() {
        Auth.auth().createUser(withEmail: username, password: password) {
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    func login() {
        Auth.auth().createUser(withEmail: username, password: password) {
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

struct loginScreen_Previews: PreviewProvider {
    static var previews: some View {
        loginScreen()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
