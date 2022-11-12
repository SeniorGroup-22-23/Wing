//
//  HomePageView.swift
//  Wing
//
//  Created by Nury Kim on 2022-10-14.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack {
            Color("MainGreen")
            VStack {
                Image("GreenLogo")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                Text("Wing")
                    .font(.custom(FontManager.KumbhSans.bold, size: 64.0))
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
