//
//  ContentView.swift
//  Login
//
//  Created by Bryn Haines on 2022-10-15.
//
import SwiftUI
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let greenColor = Color(red:121/255, green:188/255, blue:154/255)

struct ContentView : View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            WhiteLogo()
            LoginText()
            TextField("Email or phone number", text: $username)
                .padding()
                .background(.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 300)
            SecureField("Password", text: $password)
                .padding()
                .background(.white)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .frame(width: 300)
                ForgotPasswordText()
            Button(action: {print("Button tapped")}) {
                    ButtonContent()
                }
        }
        .padding()
        .background(
        BackgroundLogo())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginText: View {
    var body: some View {
        Text("Log in")
            .font(.custom("NotoSans",fixedSize:30))
            .fontWeight(.bold)
            .padding(.bottom, 20)
            .offset(y:-30)
    }
}

struct WhiteLogo: View {
    var body: some View {
        Image("WhiteLogo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .offset( y: -150)
    }
}

struct ButtonContent: View {
    var body: some View {
        Text("Sign in")
            .font(.custom("NotoSans",fixedSize:18))
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(greenColor)
            .cornerRadius(15.0)
    }
}

struct ForgotPasswordText: View {
    var body: some View {
        Text("[Forgot Password?](https://example.com)")
            .underline()
            .font(.custom("NotoSans",fixedSize:14))
            .fontWeight(.thin)
            .accentColor(Color.black)
            .padding(.bottom, 20)
            .offset(y: 15)
            
            
    }
}

struct BackgroundLogo: View {
    var body: some View {
        Image("BackgroundLogo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 400, height: 400)
            .offset(y:40)
    }
}
