//
//  PhoneNumberView.swift
//  Wing
//
//  Created by Ankita Menon on 17/10/2022.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @ObservedObject var viewModel: SignupViewModel = .method
    @State var isDisabled = true
    @State var refNumber: String = String()
    
    func checkNumber() async throws{
        let refNumber = viewModel.number.filter{
            if($0 == " "){
                return false
            }
            else if($0 == "-"){
                return false
            }
            else{
                return true
            }
        }
        if((viewModel.ext + refNumber).count > 9){
            try await viewModel.checkPhone()
        }
        
        if(viewModel.checkTaken && validateNumber() && validateExt()){
            isDisabled = false
        }
        else{
            isDisabled = true
        }
    }
    
    func validateNumber() -> Bool {
        let phonePattern = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let result = viewModel.number.range(
            of: phonePattern,
            options: .regularExpression
        )
        return result != nil
    }

    func validateExt() -> Bool {
        let pattern = #"^(\+?\d{1,3}|\d{1,4})$"#
        let result = viewModel.ext.range(
            of: pattern,
            options: .regularExpression
        )
        return result != nil
    }
    
    var body: some View {
            ZStack {
                Color(.white)
                VStack {
                    LoadWingImage()
                        .offset(y:-55)
                    Spacer()
                        .frame(height: 150)
                    Text("""
                         What's your phone
                         number?
                         """)
                        .font(.custom(FontManager.KumbhSans.semiBold, size: 24.0))
                        .multilineTextAlignment(.center)
                        .offset()
                    Spacer()
                        .frame(height: 30)
                    HStack{
                        Text("ext.")
                            .font(.custom(FontManager.NotoSans.regular, size: 13.0))
                        TextField("+1", text: $viewModel.ext)
                            .frame(width:81.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: viewModel.ext){ newValue in
                                Task{
                                    try await checkNumber()
                                }
                            }
                        TextField("123-456-7890", text: $viewModel.number)
                            .frame(width:213.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: viewModel.number){ newValue in
                                Task{
                                    try await checkNumber()
                                }
                            }
                    }
                    if (!viewModel.checkTaken) {
                        Text("This phone number is already associated with an account!")
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
                            .background(isDisabled ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(20)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    }
                    .disabled(isDisabled)
                    Spacer()
                }
            }
        }
}


struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}

