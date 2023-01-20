//
//  MessageView.swift
//  Wing
//
//  Created by Nury Kim on 2023-01-17.
//

import SwiftUI

struct Match {
    let name: String
    let username: String
    let photo: String
}

struct MessageView: View {
    
    
    var body: some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            
            VStack {
                // wing symbol and settings button
                HeaderTab()
                
                // this section shows matches
                HStack {
                    MatchesText()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20.0)
                
                
                
                Divider()
                
                // this section shows phone requests
                HStack {
                    RequestsText()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20.0)
                
                Divider()
                
                // wing symbol, match symbol, and messages symbol
                FooterTab()
            }
        }
    }
}

struct MatchesText: View {
    var body: some View {
        Text("Matches")
            .foregroundColor(.white)
            .font(.custom(FontManager.NotoSans.semiBold, size: 28.0))
    }
}

struct RequestsText: View {
    var body: some View {
        Text("Requests")
            .foregroundColor(.white)
            .font(.custom(FontManager.NotoSans.semiBold, size: 28.0))
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
