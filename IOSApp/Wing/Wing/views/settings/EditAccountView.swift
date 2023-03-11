//
//  EditAccountView.swift
//  Wing
//
//  Created by Nury Kim on 2022-12-23.
//

import SwiftUI

struct EditAccountView: View {
    @State private var firstName: String = ""
    @State private var gender = 1
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @ObservedObject var chosen_method: ChosenMethod = .method
    
    var body: some View {
        ZStack {
            Color("White")
            
            VStack {
                LoadSmallLogo()
                ShowDetailsText()
                
                HStack {
                    RequiredStar()
                    requiredFieldName(field: "First Name")
                }
                TextField("", text: $firstName)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                    .autocorrectionDisabled(true)
                if (chosen_method.email_method){
                    HStack {
                        RequiredStar()
                        requiredFieldName(field: "Phone Number")
                    }
                    TextField("", text: $phoneNumber)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .offset(y: -35)
                        .autocorrectionDisabled(true)
                    optionalFieldName(field: "Email")
                    TextField("", text: $email)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .offset(y: -35)
                        .autocorrectionDisabled(true)
                }
                else {
                    HStack {
                        RequiredStar()
                        requiredFieldName(field: "Email")
                    }
                    TextField("", text: $email)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .offset(y: -35)
                        .autocorrectionDisabled(true)
                    optionalFieldName(field: "Phone Number")
                    TextField("", text: $phoneNumber)
                        .frame(width:300.0, height: 48.0)
                        .textFieldStyle(.roundedBorder)
                        .offset(y: -35)
                        .autocorrectionDisabled(true)
                }
                VStack{
                    
                    optionalFieldName(field: "Gender")
                    Picker(selection: $gender, label: Text("Preference")) {
                        Text("Male").tag(1)
                        Text("Female").tag(2)
                        Text("Other").tag(3)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .offset(y: -20)
                        .frame(width: 300)
                    Spacer()
                    NavigationLink(destination: EditPasswordView()) {
                        Text("Next")
                            .frame(width: 231.0, height: 55.0)
                            .foregroundColor(.white)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                            .background((firstName.isEmpty) ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(20)
                    }
                    .disabled(firstName.isEmpty)
                }
            }
        }
    }
    
    func requiredFieldName(field : String) -> some View {
        return Text(field)
            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
            .frame(width: 300, alignment: .leading)
            .offset(y: -35)
    }
    
    func optionalFieldName(field : String) -> some View {
        return Text(field)
            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
            .frame(width: 300, alignment: .leading)
            .offset(y: -15)
    }
}

struct LoadSmallLogo: View {
    var body: some View {
        Image("WhiteLogo")
            .resizable()
            .frame(width: 120.0, height: 127.0)
            .offset(y:-50)
    }
}

struct ShowDetailsText: View {
    var body: some View {
        Text("Your Details")
            .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
            .offset(y: -65)
    }
}

struct ChangePasswordText: View {
    var body: some View {
        Text("Change Password")
            .font(.custom(FontManager.NotoSans.semiBold, size: 24.0))
            .offset(y: -65)
    }
}

struct RequiredStar: View {
    var body: some View {
        Text("*")
            .font(.custom(FontManager.NotoSans.regular, size : 15.0))
            .foregroundColor(Color("BrightRed"))
            .offset(x: 5, y: -32)
    }
}

struct EditPasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var checkNewPassword: String = ""
    
    func validateValues(oldPassword: String, password: String, confirmPassword: String) -> Bool {
        if (password == confirmPassword && !confirmPassword.isEmpty && !oldPassword.isEmpty){
            return true
        }
        return false
    }
    
    var body: some View {
        ZStack {
            Color("White")
            VStack {
                LoadSmallLogo()
                ChangePasswordText()
             
                HStack {
                    RequiredStar()
                    requiredFieldName(field: "Current Password")
                }
                SecureField("", text: $currentPassword)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                    .autocorrectionDisabled(true)
                
                HStack {
                    RequiredStar()
                    requiredFieldName(field: "New Password")
                }
                SecureField("", text: $newPassword)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                    .autocorrectionDisabled(true)
                
                HStack {
                    RequiredStar()
                    requiredFieldName(field: "Confirm New Password")
                }
                SecureField("", text: $checkNewPassword)
                    .frame(width:300.0, height: 48.0)
                    .textFieldStyle(.roundedBorder)
                    .offset(y: -35)
                    .autocorrectionDisabled(true)
                
                Spacer()
                NavigationLink(destination: SettingsHomeView()) {
                    Text("Save")
                        .frame(width: 231.0, height: 55.0)
                        .foregroundColor(.white)
                        .background(!(validateValues(oldPassword: currentPassword, password: newPassword, confirmPassword: checkNewPassword)) ? Color("DarkGrey") : Color("MainGreen"))
                        .cornerRadius(70)
                        .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                }
                .disabled(!(validateValues(oldPassword: currentPassword, password: newPassword, confirmPassword: checkNewPassword)))
            }

        }
    }
    func requiredFieldName(field : String) -> some View {
        return Text(field)
            .font(.custom(FontManager.NotoSans.regular, size: 15.0))
            .frame(width: 300, alignment: .leading)
            .offset(y: -35)
    }
}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView()
        //EditPasswordView()
    }
}
