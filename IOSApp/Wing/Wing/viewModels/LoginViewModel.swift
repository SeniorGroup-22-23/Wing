//
//  LoginModel.swift
//  Wing
//
//  Created by Bryn Haines on 2022-11-22.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject{

    @Published var user: User = User()
    @Published var response: Int = 0
    @Published var credential: String = ""
    @Published var password: String = ""

    func getUserbyPhone() async{

        let url = URL(string: "http://127.0.0.1:8080/user/phone/\(self.credential)/\(self.password)")!

            let urlRequest = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        do {
                            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
                            self.user = decodedUsers

                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
        
        dataTask.resume()

    }
}
