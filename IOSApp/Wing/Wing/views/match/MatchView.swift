//
//  MatchView.swift
//  Wing
//
//  Created by Nury Kim on 2022-11-29.
//

import SwiftUI

struct MatchView : View {
    @State private var name = ""
    @State private var age = 0
    @State private var images = [Image?](repeating : nil, count : 8)
    @State private var bio = ""
    @State private var prompts = [String?](repeating : "", count : 3)
    @State private var answers = [String?](repeating : "", count : 3)
    
    var body : some View {
        ZStack {
            Color("MainGreen")
                .ignoresSafeArea()
            VStack {
                HeaderTab()
                FooterTab()
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
    }
}
