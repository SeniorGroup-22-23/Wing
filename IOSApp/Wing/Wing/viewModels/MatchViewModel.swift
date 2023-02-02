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
    
    @Published var match: Match = Match()
    @Published var firstUserId: UUID = UUID()
    @Published var secondUserId: UUID = UUID()
    @Published var matchType: Int16 = 1
    
    @Published var swipe: Swipe = Swipe()
    @Published var swiperId: UUID = UUID()
    @Published var prospectId: UUID = UUID()
    @Published var swipeType: Int16 = 1
    @Published var createdAt: Date = Date()
    
    // getting info about the next profile to load to swipe on
    @Published var prospectID: [UUID] = []
    @Published var prospectProfile: [Profile] = []

    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getProspects() async throws {
        let url = URL(string: baseURL + "/prospects/\(primaryUserId)")!
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
            let decodedUsers = try JSONDecoder().decode([Profile].self, from: data)
            DispatchQueue.main.async {
                self.prospectProfile = decodedUsers
            }
        }
        else{
            print("prospects \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
    
    func loadProspectPhotos(prospectID : UUID) async throws {
        
    }
    
    func postSwipe(swiperID: UUID, prospectId: UUID) async throws {
        let url = URL(string: baseURL + "/swipe")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = Swipe(swiperId: self.swiperId, prospectId: self.prospectId, type: self.swipeType, createdAt: self.createdAt)
        
        urlRequest.httpBody = try? JSONEncoder().encode(user)

        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }

        if(httpResponse.statusCode == 200){
            let decodedUser = try JSONDecoder().decode(Swipe.self, from: data)
            DispatchQueue.main.async {
                self.swipe = decodedUser
            }
        }
        else{
            print("user \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
}
