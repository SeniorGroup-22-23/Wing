//
//  LoginModel.swift
//  Wing
//
//  Created by Bryn Haines on 2022-11-22.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject{

    static var method = LoginViewModel()
    
    @Published var user: User = User()
    @Published var isValid: Bool = false
    @Published var credential: String = ""
    @Published var password: String = ""

    func getUserbyPhone() async throws{

        let url = URL(string: "http://127.0.0.1:8080/user/phone/\(self.credential)/\(self.password)")!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                self.user = decodedUsers
                self.isValid = true
            }
        }
        else{
            throw URLError(.badServerResponse)
        }

    }
}
