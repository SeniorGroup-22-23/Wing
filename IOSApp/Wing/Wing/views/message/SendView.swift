//
//  SendView.swift
//  Wing
//
//  Created by Ankita Menon on 06/02/2023.
//

import SwiftUI

struct SendView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                LoadSendBox()
                    .offset(y: -80)
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
            }
        }
    }
}

struct LoadSendBox : View {
    @State private var daysRemaining = 3
    var body : some View {
        VStack{
            Circle()
                .fill(.white)
                .frame(width: 135, height: 135)
                .padding(.horizontal, 20)
            Text("Barbara")
                .font(.custom(FontManager.NotoSans.semiBold, size: 30.0))
                .foregroundColor(Color("DarkGreen"))
            
                
            Button("Send Your Phone Number"){
                //send phone number
            }
                .padding()
                .font(.custom(FontManager.NotoSans.semiBold, size: 16.0))
                .foregroundColor(Color("DarkGreen"))
                .background(Color("DisableGrey"))
                .cornerRadius(10)
                .frame(width: 250, height: 60)
                

        }
        .frame(width: 400, height: 550)
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
