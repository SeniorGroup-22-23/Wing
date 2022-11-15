//
//  UsernameView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct UsernameView: View {
    @State private var username: String = ""
    
    var body: some View {
        ZStack {
            Color("White")
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-50)
                Spacer()
                    .frame(height: 100)
                Text("Pick a Username")
                    .font(.custom(FontManager.NotoSans.regular, size: 24.0))
                    .padding()
                Text("""
                     This will be public and will be used by your
                     friends to find you on the app.
                     """)
                    .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 30)
                TextField("", text: $username)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                    .frame(height: 30)
                NavigationLink(destination: ProfileCompletionView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background((username.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(username.isEmpty)
                Spacer()
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}

