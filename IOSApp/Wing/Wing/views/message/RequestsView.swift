//
//  RequestsView.swift
//  Wing
//
//  Created by Ankita Menon on 29/01/2023.
//

import SwiftUI

let message = "I think I've seen you around campus before"
let passedName = "Francis"

struct RequestsView: View {
    
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                LoadRequestBox()
                    .offset(y: -40)
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
            }
        }
    }
}

struct LoadRequestBox : View {

    var body : some View {
        VStack{
            HStack{
                Circle()
                    .fill(.white)
                    .frame(width: 135, height: 135)
                VStack{
                    Text(passedName)
                        .font(.custom(FontManager.NotoSans.semiBold, size: 30.0))
                        .foregroundColor(Color("DarkGreen"))
                        .frame(width: 200, alignment: .leading)
                    Text("is requesting your phone number")
                        .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                        .foregroundColor(Color("DarkGreen"))
                        .frame(width: 200, alignment: .leading)
                }
                
            }
            Text(message)
                .font(.custom(FontManager.NotoSans.regular, size: 17.0))
                .foregroundColor(Color(.white))
                .frame(width: 310, height: 180)
                .padding()
                .background(Rectangle().fill(Color("DarkGreen").opacity(0.3)).shadow(radius: 10))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                
            Spacer()
                .frame(height: 30)
            HStack{
                Button(action: {
                        //Deny
                    }) {
                        Text("Deny")
                    }
                    .foregroundColor(Color("BrightRed"))
                    .padding(.horizontal, 60)
                    .padding(.vertical, 12)
                    .background(Color("DisableGrey").opacity(0.8))
                    .cornerRadius(10)
                Button(action: {
                        //Accept
                    }) {
                        Text("Accept")
                    }
                    .foregroundColor(Color("BrightBlue"))
                    .padding(.horizontal, 60)
                    .padding(.vertical, 12)
                    .background(Color("DisableGrey").opacity(0.8))
                    .cornerRadius(10)
            }
            

        }
        .frame(width: 350, height: 550)
    }
}

struct RequestsView_Previews: PreviewProvider {
    var passedName: String
    static var previews: some View {
        RequestsView()
    }
}
