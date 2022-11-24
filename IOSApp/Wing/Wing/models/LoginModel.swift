//
//  LoginModel.swift
//  Wing
//
//  Created by Bryn Haines on 2022-11-22.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject{
    
    
    @Published var response: Int = 0
    @Published var credential: String = ""
    @Published var password: String = ""
    
    func getUserbyPhone() async{
        
        let url = URL(string: "http://127.0.0.1:8080/user/phone/\(self.credential)/\(self.password)")!
       
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let response = response as? HTTPURLResponse else{
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            DispatchQueue.main.async {
                self.response = response.statusCode
            }
        }.resume()
    }
}
