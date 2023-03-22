//
//  MatchViewModel.swift
//  Wing
//
//  Created by Nury Kim on 2023-01-24.
//

import Foundation
import SwiftUI

class MatchViewModel: ObservableObject{
    static var method = MatchViewModel()
    
    // this is the user
    @Published var user: User = User()
    @Published var primaryUserId: UUID = UUID()
    
    @Published var swipeProspectID: UUID = UUID()
    @Published var swipeType: Int16 = 1
    
    @Published var match: Bool = false
    @Published var wingLikeProspect: Bool = false
    
    // getting info about the next profile to load to swipe on
    @Published var prospectID: [UUID] = []
    @Published var prospectProfile: Profile = Profile()
    @Published var prospectPhotos: [Photo] = []
    
    @Published var promptResponses: [PromptResponse] = []
    @Published var prompt: Prompt = Prompt()

    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getPromptResponses(prospectID : UUID) async throws {
        let url = URL(string: baseURL + "/prompts/\(prospectID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode([PromptResponse].self, from: data)
            DispatchQueue.main.async {
                self.promptResponses = decodedUsers
            }
        }
        else{
            print("prompt responses \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }

    func getPrompt(promptID : UUID) async throws {
        let url = URL(string: baseURL + "/prompt/\(promptID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        
        if(httpResponse.statusCode == 200){
            let decodedPrompt = try JSONDecoder().decode(Prompt.self, from: data)
            DispatchQueue.main.async {
                self.prompt = decodedPrompt
            }
        }
        else{
            print("prompts \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func getProspects() async throws {
        let url = URL(string: baseURL + "/prospects/\(self.primaryUserId)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUsers = try JSONDecoder().decode([UUID].self, from: data)
            DispatchQueue.main.async {
                self.prospectID = decodedUsers
            }
        }
        else{
            print("prospects \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func loadProspectProfile(prospectID : UUID) async throws {
        let url = URL(string: baseURL + "/profileId/\(prospectID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedUser = try decoder.decode(Profile.self, from: data)
            DispatchQueue.main.async {
                self.prospectProfile = decodedUser
            }
            
        }
        else{
            print("prospect profile \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }

    }

    func loadProspectPhotos() async throws {
        self.prospectPhotos = [] //empty previous prospects photos
        
        let url = URL(string: baseURL + "/photo/userId/\(self.prospectProfile.userId ?? UUID())")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedPhotos = try JSONDecoder().decode([Photo].self, from: data)
            DispatchQueue.main.async {
                self.prospectPhotos = decodedPhotos
            }
        }
        else{
            print("prospect profile photos \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func postSwipe() async throws {
        let url = URL(string: baseURL + "/swipe")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let swipe = Swipe(swiperId: self.primaryUserId, prospectId: self.swipeProspectID, type: self.swipeType)
        urlRequest.httpBody = try? JSONEncoder().encode(swipe)

        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedSwipe = try JSONDecoder().decode(Bool.self, from: data)
            DispatchQueue.main.async {
                self.match = decodedSwipe
            }
        }
        else{
            print("swipe \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func checkWingLike() async throws {
        let url = URL(string: baseURL + "/wing/like/\(self.prospectProfile.userId!)/\(self.primaryUserId)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
      
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let wingLike = try JSONDecoder().decode(Bool.self, from: data)
            DispatchQueue.main.async {
                self.wingLikeProspect = wingLike
            }
        }
        else{
            print("wing like \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
}
