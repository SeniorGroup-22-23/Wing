//
//  EmailAddressView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct EmailAddressView: View {
    
    @State private var email: String = ""
    @State private var emailIsValid: Bool = true
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("White")
                VStack {
                    Image("WhiteLogo")
                        .resizable()
                        .frame(width: 120.0, height: 127.0)
                        .offset(y:-30)
                    Spacer()
                        .frame(height: 150)
                    Text("""
                         What's your email
                         address?
                         """)
                        .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 30)
                    TextField("", text: $email)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .onChange(of: email) { newValue in if(newValue.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                            self.emailIsValid = true
                        }
                            else {
                                self.emailIsValid = false
                            }
                        }
                        //.foregroundColor(emailIsValid ? Color.green : Color.red)
                    Spacer()
                        .frame(height: 30)
                    NavigationLink(destination: ConfirmationCodeView()) {
                        Text("Next")
                            .frame(width: 231.0, height: 55.0)
                            .foregroundColor(.white)
                            .background((!emailIsValid || email.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(20)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    }
                    .disabled(!emailIsValid || email.isEmpty)
                    Spacer()
                }
            }
        }
    }
}

struct EmailAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAddressView()
    }
}

