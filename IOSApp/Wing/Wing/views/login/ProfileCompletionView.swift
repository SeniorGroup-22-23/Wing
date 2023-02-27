//
//  ProfileCompletionView.swift
//  Wing
//
//  Created by Ankita Menon on 23/10/2022.
//

import SwiftUI

struct ProfileCompletionView: View {

    @State private var confirmPassword: String = ""
    let AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;

    @ObservedObject var chosen_method: ChosenMethod = .method
    @ObservedObject var viewModel: SignupViewModel = .method
    
    @State var isDisabled = false
    @State var refNumber: String = String()
    
    @State private var emailDisabled: Bool = false
    
    func validateValues(password: String, confirmPassword: String, firstName: String, birthday: Date) -> Bool {
        if (password == confirmPassword && !confirmPassword.isEmpty){
            if (birthday < AGE && !firstName.isEmpty){
                return true
            }
        }
        return false
    }
    
    func checkEmail() async throws{
        if(viewModel.email.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
            try await viewModel.checkEmail()
            if(viewModel.checkTaken){
                emailDisabled = false
            }
            else{
                emailDisabled = true
            }
        }
        else {
            emailDisabled = true
        }
    }

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
        if((viewModel.ext + viewModel.number).count > 0){
            if(viewModel.checkTaken && validateNumber() && validateExt()){
                isDisabled = false
            }
            else{
                isDisabled = true
            }
        }
        else{
            isDisabled = false
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
                    .offset(y:-47)
                Text("Complete Your Profile")
                    .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
                    .offset(y: -65)
                HStack {
                    Text("*")
                        .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                        .foregroundColor(Color("BrightRed"))
                        .offset(x: 5, y: -32)
                    Text("Password")
                        .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                        .frame(width: 300, alignment: .leading)
                        .offset(y: -35)
                }
                SecureField("", text: $viewModel.password)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                HStack {
                    Text("*")
                        .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                        .foregroundColor(Color("BrightRed"))
                        .offset(x: 5, y: -32)
                    Text("Confirm password")
                        .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                        .frame(width: 300, alignment: .leading)
                        .offset(y: -35)
                }
                SecureField("", text: $viewModel.confirmPassword)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                VStack {
                    HStack{
                        Text("*")
                            .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                            .foregroundColor(Color("BrightRed"))
                            .offset(x: 5, y: -32)
                        Text("First Name")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .frame(width: 300, alignment: .leading)
                            .offset(y: -35)
                    }
                    TextField("", text: $viewModel.name)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .offset(y: -35)
                        .autocorrectionDisabled(true)
                    HStack {
                        Text("*")
                            .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                            .foregroundColor(Color("BrightRed"))
                            .offset(x: 43, y: -25)
                        DatePicker(selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date) {
                            Text("Birthday")
                                .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                                .offset(x: 140, y: 0)
                        }
                        .offset(x: -100, y: -25)
                    }
                    HStack{
                        Text("*")
                            .font(.custom(FontManager.NotoSans.regular, size : 15.0))
                            .foregroundColor(Color("BrightRed"))
                            .offset(x: 5, y: -19)
                        Text("Gender")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .frame(width: 300, alignment: .leading)
                            .offset(y: -20)
                    }
                    Picker(selection: $viewModel.gender, label: Text("Preference")) {
                        Text("Male").tag(Int16(1))
                        Text("Female").tag(Int16(2))
                        Text("Other").tag(Int16(3))
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .offset(y: -20)
                    .frame(width: 300)
                    if (chosen_method.email_method){
                        Text("Phone number")
                        .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                        .frame(width: 300, alignment: .leading)
                        .offset(y: -15)
                        HStack{
                            Text("ext.")
                                .font(.custom(FontManager.NotoSans.regular, size: 15.0))
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
                        }.offset(y: -20)
                        if (!viewModel.checkTaken) {
                            Text("This phone number is already associated with an account!")
                                .font(.custom(FontManager.NotoSans.regular, size: 13.0))
                                .foregroundColor(.red)
                                .frame(height: 20)
                                .offset(y: -30)
                        }
                        else{
                            Spacer()
                                .frame(height: 43)
                                .offset(y: -20)
                        }
                    }
                    else{
                        Text("Email")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .frame(width: 300, alignment: .leading)
                            .offset(y: -15)
                        TextField("", text: $viewModel.email)
                            .frame(width:300.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .offset(y: -20)
                            .onChange(of: viewModel.email) { newValue in
                                Task{
                                    try await checkEmail()
                                }
                            }
                        if (!viewModel.checkTaken) {
                            Text("This email is already associated with an account!")
                                .font(.custom(FontManager.NotoSans.regular, size: 13.0))
                                .foregroundColor(.red)
                                .frame(height: 20)
                                .offset(y: -30)
                        }
                        else{
                            Spacer()
                                .frame(height: 37)
                                .offset(y: -20)
                        }
                    }
                }
                NavigationLink(destination: MatchPreferenceView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(!(validateValues(password: viewModel.password, confirmPassword: viewModel.confirmPassword, firstName: viewModel.name, birthday: viewModel.birthdate)) || isDisabled || emailDisabled ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(!(validateValues(password: viewModel.password, confirmPassword: viewModel.confirmPassword, firstName: viewModel.name, birthday: viewModel.birthdate)) || isDisabled || emailDisabled)
                .offset(y: -25)
            }
        }
    }
}



struct ProfileCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCompletionView()
    }
}

