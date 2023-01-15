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
    
    func validateValues(password: String, confirmPassword: String, firstName: String, birthday: Date) -> Bool {
        if (password == confirmPassword && !confirmPassword.isEmpty){
            if (birthday < AGE && !firstName.isEmpty){
                return true
            }
        }
        return false
    }
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                Image("WhiteLogo")
                    .resizable()
                    .frame(width: 120.0, height: 127.0)
                    .offset(y:-50)
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
                SecureField("", text: $confirmPassword)
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
                        Text("Male").tag(1)
                        Text("Female").tag(2)
                        Text("Other").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .offset(y: -20)
                    .frame(width: 300)
                    if (chosen_method.email_method){
                        Text("Phone number")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .frame(width: 300, alignment: .leading)
                            .offset(y: -15)
                        TextField("", text: $viewModel.number)
                            .frame(width:300.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                            .offset(y: -20)
                    }
                    else {
                        Text("Email")
                            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
                            .frame(width: 300, alignment: .leading)
                            .offset(y: -15)
                        TextField("", text: $viewModel.email)
                            .frame(width:300.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                            .offset(y: -20)
                    }
                }
                NavigationLink(destination: MatchPreferenceView()) {
                    Text("Next")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(!(validateValues(password: viewModel.password, confirmPassword: confirmPassword, firstName: viewModel.name, birthday: viewModel.birthdate)) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(20)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(!validateValues(password: viewModel.password, confirmPassword: confirmPassword, firstName: viewModel.name, birthday: viewModel.birthdate))
            }
        }
    }
}

struct ProfileCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCompletionView()
    }
}

