//
//  PhoneNumberView.swift
//  Wing
//
//  Created by Ankita Menon on 17/10/2022.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @State private var ext: String = ""
    @State private var number: String = ""
    
    func validateNumber(value: String) -> Bool {
        let phonePattern = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let result = value.range(
            of: phonePattern,
            options: .regularExpression
        )
        return result != nil
    }
    
    func validateExt(value: String) -> Bool {
        let pattern = #"^(\+?\d{1,3}|\d{1,4})$"#
        let result = value.range(
            of: pattern,
            options: .regularExpression
        )
        return result != nil
    }
    
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
                         What's your phone
                         number?
                         """)
                        .font(.custom(FontManager.KumbhSans.regular, size: 24.0))
                        .multilineTextAlignment(.center)
                        .offset()
                    Spacer()
                        .frame(height: 30)
                    HStack{
                        Text("ext.")
                            .font(.custom(FontManager.NotoSans.regular, size: 13.0))
                        TextField("+1", text: $ext)
                            .frame(width:81.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                        TextField("123-456-7890", text: $number)
                            .frame(width:213.0, height: 48.0)
                            .textFieldStyle(.roundedBorder)
                    }
                    Spacer()
                        .frame(height: 30)
                    NavigationLink(destination: ConfirmationCodeView()) {
                        Text("Next")
                            .frame(width: 231.0, height: 55.0)
                            .foregroundColor(.white)
                            .background((!(self.validateExt(value: ext)) || !(self.validateNumber(value: number))) ? Color("DarkGrey") : Color("MainGreen"))
                            .cornerRadius(20)
                            .font(.custom(FontManager.NotoSans.regular, size: 16.0))
                    }
                    .disabled(!(self.validateExt(value: ext)) || !(self.validateNumber(value: number)))
                        
                    Spacer()
                }
            }
        }
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}

