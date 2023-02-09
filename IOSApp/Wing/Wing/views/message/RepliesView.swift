//
//  RepliesView.swift
//  Wing
//
//  Created by Ankita Menon on 29/01/2023.
//

import SwiftUI

struct RepliesView: View {
    @Binding var numberChosen: Match
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                    .offset(y: 10)
                LoadReplyBox(numberChosen: $numberChosen)
                    .offset(y: -70)
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
            }
        }
    }
}

struct LoadReplyBox : View {
    @Binding var numberChosen: Match
    
    var body : some View {
        VStack{
            Circle()
                .fill(.white)
                .frame(width: 135, height: 135)
                .padding(.horizontal, 20)
            Text("\(numberChosen.name)")
                .font(.custom(FontManager.NotoSans.semiBold, size: 30.0))
                .foregroundColor(Color("DarkGreen"))
            if (numberChosen.numberSent != false){
                Text("sent you a phone number")
                    .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                    .foregroundColor(Color("DarkGreen"))
                Text("\(numberChosen.number)")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 25.0))
                    .foregroundColor(Color(.white))
                    .frame(width: 310, height: 70)
                    .background(Rectangle().fill(Color("DarkGreen").opacity(0.3)).shadow(radius: 10))
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 15)
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
        .onAppear{
            numberChosen.new = false
        }
    }
}

struct RepliesView_Previews: PreviewProvider {
    @State static var selectedNumber = Match(id: 1, name: "Hannah", photo: "", new: true, number: "+1 (886) 123-1234", numberSent: false)
    
    static var previews: some View {
        RepliesView(numberChosen: $selectedNumber)
    }
}
