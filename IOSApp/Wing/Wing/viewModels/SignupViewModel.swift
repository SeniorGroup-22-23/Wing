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
    @Published var confirmPassword: String = String()
    @Published var email: String = String()
    @Published var ext: String = String()
    @Published var number: String = String()
    
    @Published var profile: Profile = Profile()
    @Published var name: String = String()
    @Published var birthdate: Date = Date()
    @Published var occupation: String = String()
    @Published var bio: String = String()
    @Published var gender: Int16 = 1
    @Published var preference: Int16 = 1
    @Published var minAge: Int16 = 18
    @Published var maxAge: Int16 = 18
    @Published var maxDistance: Int16 = 1
    @Published var currLatitude: Double = Double()
    @Published var currLongitude: Double = Double()
    
    @Published var promptList: [Prompt] = []
    @Published var prompt1: Prompt = Prompt()
    @Published var prompt2: Prompt = Prompt()
    @Published var prompt3: Prompt = Prompt()
    @Published var ans1: String = String()
    @Published var ans2: String = String()
    @Published var ans3: String = String()
    @Published var promptResponses: [PromptResponse] = []
    
    @Published var isValid: Bool = false
    @Published var credential: String = ""
    
    @Published var imagesData = [Data?](repeating : nil, count : 8)
    
    @Published var profilePreview: ProfilePreview = ProfilePreview()
    
    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getUsernames(username: String) async throws{
        
        let url = URL(string: baseURL + "/usernames/\(username)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode([String].self, from: data)
            DispatchQueue.main.async {
                self.isTaken = false
                for name in decodedUsers{
                    if(name == username){
                        self.isTaken = true
                        return
                    }
                }
            }
        }
        else{
            print("usernames \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func setUser() async throws{

        let url = URL(string: baseURL + "/user")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = User(username: self.username, password: self.password, phone: self.ext + self.number, email: self.email)
        
        urlRequest.httpBody = try? JSONEncoder().encode(user)

        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }

        if(httpResponse.statusCode == 200){
            let decodedUser = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                self.user = decodedUser
            }
        }
        else{
            print("user \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }

    }
    
    func setProfile() async throws{

        let url = URL(string: baseURL + "/profile")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let profile = Profile(userId: self.user.id, name: self.name, birthdate: self.birthdate, occupation: self.occupation, bio: self.bio, gender: self.gender, preference: self.preference, minAge: self.minAge, maxAge: self.maxAge, maxDistance: self.maxDistance, currLatitude: self.currLatitude, currLongitude: self.currLongitude)
        
        print(profile)

        urlRequest.httpBody = try? encoder.encode(profile)
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){

            let decodedProfile = try decoder.decode(Profile.self, from: data)
            DispatchQueue.main.async {
                self.profile = decodedProfile
            }
        }
        else{
            print("profile \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getPrompts() async throws {

        let url = URL(string: baseURL + "/prompts")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedPrompts = try JSONDecoder().decode([Prompt].self, from: data)
            DispatchQueue.main.async {
                self.promptList = decodedPrompts
            }
        }
        else{
            print("prompts \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }

    }
    
    func setProfilePreview() async throws{

        let url = URL(string: baseURL + "/profilePreview")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let profilePreview = ProfilePreview(userId: self.user.id, username: self.username, name: self.name, primaryPhoto: self.imagesData[0])
        
        print(profilePreview)

        urlRequest.httpBody = try? encoder.encode(profilePreview)
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedProfilePreview = try decoder.decode(ProfilePreview.self, from: data)
            DispatchQueue.main.async {
                self.profilePreview = decodedProfilePreview
            }
        }
        else{
            print("profile preview \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    
    func setPromptResponse(n: Int = 1) async throws{

        let url = URL(string: baseURL + "/prompts/user")!
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
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedPromptResponse = try JSONDecoder().decode(PromptResponse.self, from: data)
            DispatchQueue.main.async {
                self.promptResponses.append(decodedPromptResponse)
            }
        }
        else{
            print("user prompt response \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    
    ///LOGIN functionality
    
    func getUserbyPhone() async throws{

        let url = URL(string: baseURL + "/user/phone/\(self.credential)/\(self.password)")!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                self.user = decodedUsers
                self.isValid = true
            }
        }
//        else{
//            throw URLError(.badServerResponse)
//
//        }
    }
    
    func getUserbyEmail() async throws{

        let url = URL(string: baseURL + "/user/email/\(self.credential)/\(self.password)")!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode(User.self, from: data)
            DispatchQueue.main.async {
                self.user = decodedUsers
                self.isValid = true
            }
        }
//        else{
//            throw URLError(.badServerResponse)
//
//        }
    }
}
