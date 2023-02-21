//
//  NoProspectsMatchView.swift
//  Wing
//
//  Created by Nury Kim on 2023-02-21.
//

import SwiftUI

struct NoProspectsMatchView: View {
    var body: some View {
        ZStack {
            Image("GreenLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 420, height: 420)
                .opacity(0.2)
            
            VStack {
                Text("You're all caught up!")
                    .font(.custom(FontManager.NotoSans.semiBold, size : 28.0))
                Text("Expand your distance preferences or wait to see new profiles in your area!")
                    .font(.custom(FontManager.NotoSans.regular, size : 15.0))
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct NoProspectsMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NoProspectsMatchView()
    }
}
