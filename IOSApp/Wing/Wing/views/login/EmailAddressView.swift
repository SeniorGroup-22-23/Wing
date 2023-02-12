//
//  EmailAddressView.swift
//  Wing
//
//  Created by Ankita Menon on 19/10/2022.
//

import SwiftUI

struct EmailAddressView: View {
    
    @State private var emailIsValid: Bool = false
    @ObservedObject var viewModel: SignupViewModel = .method
    
    func checkEmail() async throws{
        if(emailIsValid){
            try await viewModel.checkEmail()
        }
    }

    
    var body: some View {
            ZStack {
                Color(.white)
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
                    TextField("", text: $viewModel.email)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .onChange(of: viewModel.email) { newValue in if(newValue.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                            self.emailIsValid = true
                            Task{
                                try await checkEmail()
                            }
                        }
                            else {
                                self.emailIsValid = false
                            }
                        }
                    if (!viewModel.checkTaken && self.emailIsValid) {
                        Text("This email is already associated with an account!")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .foregroundColor(.red)
                    }
                    else{
                        Spacer()
                            .frame(height: 30)
                    }
                    NavigationLink(destination: UsernameView()) {
                        Text("Next")
                            .frame(width: 231.0, height: 55.0)
                            .foregroundColor(.white)
                            .background((!emailIsValid || viewModel.email.isEmpty || !viewModel.checkTaken) ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(20)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    }
                    .disabled(!emailIsValid || viewModel.email.isEmpty || !viewModel.checkTaken)
                    Spacer()
                }
            }
        }
}

struct EmailAddressView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAddressView()
    }
}

