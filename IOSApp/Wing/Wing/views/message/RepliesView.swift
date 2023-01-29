//
//  RepliesView.swift
//  Wing
//
//  Created by Ankita Menon on 29/01/2023.
//

import SwiftUI

let number = "+1 (506) 123-1234"

struct RepliesView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                HeaderTab() // wing symbol and settings button
                    .frame(width: 380)
                LoadReplyBox()
                    .offset(y: -60)
                FooterTab() // wing symbol, match symbol, and messages symbol
                    .frame(width: 300)
            }
        }
    }
}

struct LoadReplyBox : View {
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
            Text("accepted your request")
                .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                .foregroundColor(Color("DarkGreen"))
            Text(number)
                .font(.custom(FontManager.NotoSans.semiBold, size: 25.0))
                .foregroundColor(Color(.white))
                .frame(width: 310, height: 70)
                .background(Rectangle().fill(Color("DarkGreen").opacity(0.3)).shadow(radius: 10))
                .cornerRadius(10)
                
            Text("*available for \(daysRemaining) days")
                .onAppear(perform: updateDaysRemaining)
                .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                .foregroundColor(Color("DarkGreen"))
                .frame(width: 310, alignment: .leading)

        }
        .frame(width: 400, height: 550)
    }
    func updateDaysRemaining() {
            // Get the current date and calculate the number of days until a specific date
            let currentDate = Date()
            let endDate = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)
            let daysRemaining = Calendar.current.dateComponents([.day], from: currentDate, to: endDate!).day!
            self.daysRemaining = daysRemaining
        }
}

struct RepliesView_Previews: PreviewProvider {
    static var previews: some View {
        RepliesView()
    }
}
