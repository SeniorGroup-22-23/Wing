//
//  SignupViewModel.swift
//  Wing
//
//  Created by Bryn Haines on 2022-12-29.
//

import Foundation
import SwiftUI


class SignupViewModel: ObservableObject{
    
    static var method = SignupViewModel()

    @Published var isTaken: Bool = false
    
    @Published var user: User = User()
    @Published var username: String = String()
    @Published var password: String = String()
    @Published var email: String = String()
    @Published var ext: String = String()
    @Published var number: String = String()
    
    @Published var profile: Profile = Profile()
    @Published var name: String = String()
    @Published var birthdate: Date = Date()
    @Published var occupation: String = String()
    @Published var bio: String = String()
    @Published var gender: Int16 = Int16()
    @Published var preference: Int16 = Int16()
    @Published var minAge: Int16 = Int16()
    @Published var maxAge: Int16 = Int16()
    @Published var maxDistance: Int16 = Int16()
    
    @Published var promptList: [Prompt] = []
    @Published var prompt1: Prompt = Prompt()
    @Published var prompt2: Prompt = Prompt()
    @Published var prompt3: Prompt = Prompt()
    @Published var ans1: String = String()
    @Published var ans2: String = String()
    @Published var ans3: String = String()
    @Published var promptResponses: [PromptResponse] = []
    
    
    func getUsernames(username: String) async throws{
        
        let url = URL(string: "http://127.0.0.1:8080/usernames/\(username)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode([String].self, from: data)
            DispatchQueue.main.async {
                for name in decodedUsers{
                    if(name == username){
                        self.isTaken = true
                    }
                    else{
                        self.isTaken = false
                    }
                }
            }
        }
        else{
            throw URLError(.badServerResponse)
        }
    }
    
    func setUser() async throws{

        let url = URL(string: "http://127.0.0.1:8080/user")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(username: self.username, password: self.password, phone: self.ext + self.number, email: self.email)
        urlRequest.httpBody = try? JSONEncoder().encode(user)

        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedUser = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                self.user = decodedUser
            }
        }
        else{
            throw URLError(.badServerResponse)
        }

    }
    
    func setProfile() async throws{

        let url = URL(string: "http://127.0.0.1:8080/profile")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let profile = Profile(userId: self.user.id, name: self.name, birthdate: self.birthdate, occupation: self.occupation, bio: self.bio, gender: self.gender, preference: self.preference, minAge: self.minAge, maxAge: self.maxAge, maxDistance: self.maxDistance)
        
        print(profile)
        
        urlRequest.httpBody = try? JSONEncoder().encode(profile)
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedProfile = try JSONDecoder().decode(Profile.self, from: data)
            DispatchQueue.main.async {
                self.profile = decodedProfile
            }
        }
        else{
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getPrompts() async throws {

        let url = URL(string: "http://127.0.0.1:8080/prompts")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedPrompts = try JSONDecoder().decode([Prompt].self, from: data)
            DispatchQueue.main.async {
                self.promptList = decodedPrompts
            }
        }
        else{
            throw URLError(.badServerResponse)
        }

    }
    
    func setPromptResponse(n: Int = 1) async throws{

        let url = URL(string: "http://127.0.0.1:8080/prompts/user")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var ans = String()
        if(n == 1){
            ans = self.ans1
        }
        else if(n == 2){
            ans = self.ans2
        }
        else{
            ans = self.ans3
        }
        
        let promptResponse = PromptResponse(userId: self.user.id, promptId: self.prompt1.id, responseText: ans)
        
        urlRequest.httpBody = try? JSONEncoder().encode(promptResponse)

        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else { return }
        
        if(response.statusCode == 200){
            let decodedPromptResponse = try JSONDecoder().decode(PromptResponse.self, from: data)
            DispatchQueue.main.async {
                self.promptResponses.append(decodedPromptResponse)
            }
        }
        else{
            throw URLError(.badServerResponse)
        }
    }
}
