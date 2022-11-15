//
//  ConfirmationCodeView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct ConfirmationCodeView: View {
    @State private var code: String = ""
    
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
                Text("Confirmation Code")
                    .font(.custom(FontManager.NotoSans.regular, size: 24.0))
                    .padding()
                Text("""
                     Enter the confirmation code that was
                     sent to your email.
                     """)
                    .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                    .multilineTextAlignment(.center)
                    .offset()
                Spacer()
                    .frame(height: 20)
                TextField("", text: $code)
                    .frame(width:80.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                    .frame(height: 30)
                NavigationLink(destination: UsernameView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background((code.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(code.isEmpty)
                Spacer()
                Button(
                  "Resend code",
                  action: {
                    //some code
                  }
                )
                .font(.custom(FontManager.NotoSans.regular, size: 15.0))
            }
        }

    }
}

struct ConfirmationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationCodeView()
    }
}

