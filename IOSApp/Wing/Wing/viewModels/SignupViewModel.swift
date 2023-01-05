//
//  SignupViewModel.swift
//  Wing
//
//  Created by Bryn Haines on 2022-12-29.
//

import Foundation
import SwiftUI


class SignupViewModel: ObservableObject{

    @Published var isTaken: Bool = false
    @Published var user: User = User()
    @Published var username: String = String()
    @Published var password: String = String()
    @Published var email: String = String()
    @Published var ext: String = String()
    @Published var number: String = String()
    static let method = SignupViewModel()
    
    func getUsernames(username: String) async{

        let url = URL(string: "http://127.0.0.1:8080/usernames/\(username)")!

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
                            let decodedUsers = try JSONDecoder().decode([String].self, from: data)
                            for name in decodedUsers{
                                if(name == username){
                                    self.isTaken = true
                                }
                                else{
                                    self.isTaken = false
                                }
                            }
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
        
        dataTask.resume()
    }
    
    func setUser() async{

        print(self.username)
        let url = URL(string: "http://127.0.0.1:8080/user")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(username: SignupViewModel.method.username, password: SignupViewModel.method.password, phone: SignupViewModel.method.ext + SignupViewModel.method.number, email: SignupViewModel.method.email)
        urlRequest.httpBody = try? JSONEncoder().encode(user)

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
                        print(user)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
}
