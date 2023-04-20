//
//  portfolio.swift
//  aitrading
//
//  Created by Gerald Simon on 29/03/23.
//

import SwiftUI

struct portfolio: View {
    var body: some View {
        VStack {
            Text("Your Portfolio")
                .foregroundColor(.gray)
            HStack(alignment: .top){
                Text("$999")
                    .bold()
                Text("2.5%")
                    .font(.title3)
            }
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .frame(maxWidth: .infinity)
        .background(
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray))
    }
}

struct portfolio_Previews: PreviewProvider {
    static var previews: some View {
        portfolio()
    }
}
