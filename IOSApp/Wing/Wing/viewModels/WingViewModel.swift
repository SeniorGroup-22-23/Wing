//
//  WingViewModel.swift
//  Wing
//
//  Created by Bryn Haines on 2023-03-03.
//
import Foundation
import SwiftUI

class WingViewModel: ObservableObject{
    
    static var method : WingViewModel = WingViewModel()
    
    @Published var wingedList: [Wing] = []
    @Published var wingedProfiles: [Profile] = []
    
    @Published var userID: UUID = UUID()
    
    @Published var friendIDs: [String] = []
    @Published var friendProfilePreviews: [ProfilePreview] = []
    
    @Published var friendRequests: [Friendship] = []
    @Published var friendRequestPreviews: [ProfilePreview] = []
    
    @Published var searchedUser: ProfilePreview = ProfilePreview()
    @Published var isSearchRequested: Bool = Bool()
    
    @Published var confirmedFriendRequests: [Friendship] = []
    
    @Published var requestedFriends: [Friendship] = []
    
    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func setMethod(){
        WingViewModel.method = WingViewModel()

    }
    
    func getWings() async throws {

        let url = URL(string: baseURL + "/wings/\(self.userID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedWings = try JSONDecoder().decode([Wing].self, from: data)
            DispatchQueue.main.async {
                self.wingedList = decodedWings
            }
        }
        else{
            print("get wings \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }

    }
    
    func getWingProfile(prospectID : UUID) async throws {
        
        let url = URL(string: baseURL + "/profile/\(prospectID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedProfile = try decoder.decode(Profile.self, from: data)
            DispatchQueue.main.async {
                self.wingedProfiles.append(decodedProfile)
            }
        }
        else{
            print("get winged profiles \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getFriendIDs() async throws {
        
        let url = URL(string: baseURL + "/friends/\(self.userID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedIDs = try decoder.decode([String].self, from: data)
            DispatchQueue.main.async {
                self.friendIDs = decodedIDs
            }
        }
        else{
            print("get friend IDs \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getFriendProfilePreviews(friendID : String) async throws {
        
        let url = URL(string: baseURL + "/profilePreview/id/\(friendID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedProfilePreviews = try decoder.decode(ProfilePreview.self, from: data)
            DispatchQueue.main.async {
                self.friendProfilePreviews.append(decodedProfilePreviews)
            }
        }
        else{
            print("get friend profile previews \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func clearFriendProfiles(){
        self.friendProfilePreviews = []
    }
    
    //Returns friendships with status of 1
    func getFriendRequests() async throws {
        
        let url = URL(string: baseURL + "/friendRequests/\(self.userID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedRequests = try decoder.decode([Friendship].self, from: data)
            DispatchQueue.main.async {
                self.friendRequests = decodedRequests
            }
        }
        else{
            print("get friendships \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getFriendRequestProfiles(requesterID: UUID) async throws {
        
        let url = URL(string: baseURL + "/profilePreview/userId/\(requesterID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedPreview = try decoder.decode(ProfilePreview.self, from: data)
            DispatchQueue.main.async {
                self.friendRequestPreviews.append(decodedPreview)
            }
        }
        else{
            print("get friendships \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func clearFriendRequestProfiles(){
        DispatchQueue.main.async {
            self.friendRequestPreviews = []
        }
    }
    
    //Returns an array of friendships (friend records with status 2)
    func getConfirmedFriendRequests() async throws{
        
        let url = URL(string: baseURL + "/friendships/\(self.userID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedRequests = try decoder.decode([Friendship].self, from: data)
            DispatchQueue.main.async {
                self.confirmedFriendRequests = decodedRequests
            }
        }
        else{
            print("get friendships \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func deleteFriendship(friendID: UUID) async throws {

        var friend = self.confirmedFriendRequests.filter{$0.requesterId == friendID || $0.respondentId == friendID}[0]
        
        friend.status = 3

        let url = URL(string: baseURL + "/friend")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try? encoder.encode(friend)
        
        let (_,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            return
        }
        else{
            print("delete friendship \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func searchUser(username: String) async throws {
        
        let url = URL(string: baseURL + "/profilePreview/username/\(username)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        DispatchQueue.main.async {
            self.searchedUser = ProfilePreview()
            self.isSearchRequested = false
        }
        
        if(httpResponse.statusCode == 200){
            let decodedSearch = try decoder.decode(ProfilePreview.self, from: data)
            DispatchQueue.main.async {
                self.searchedUser = decodedSearch
                print(self.searchedUser)
                print(self.friendRequests)
                for requestedFriend in self.requestedFriends{
                    if(requestedFriend.requesterId == self.searchedUser.userId || requestedFriend.respondentId == self.searchedUser.userId){
                        self.isSearchRequested = true
                        print(self.isSearchRequested)
                    }
                }
            }
        }
        else{
            print("get friendships \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func getRequestedFriends() async throws{
        
        let url = URL(string: baseURL + "/requestedFriends/\(self.userID)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedRequests = try decoder.decode([Friendship].self, from: data)
            DispatchQueue.main.async {
                self.requestedFriends = decodedRequests
            }
        }
        else{
            print("get requested friends \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    
    func addFriend(friendID: UUID) async throws {
        
        let url = URL(string: baseURL + "/friend")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let friend = Friendship(requesterId: self.userID, respondentId: friendID, status: 1)
        
        urlRequest.httpBody = try? encoder.encode(friend)
        
        let (_,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            return
        }
        else{
            print("get friendships \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    func acceptFriend(friendID: UUID) async throws {
        
        if(self.friendRequests.count >= 1){

            var friend = self.friendRequests.filter{$0.requesterId == friendID || $0.respondentId == friendID}[0]
            
            friend.status = 2
            
            let url = URL(string: baseURL + "/friend")!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            urlRequest.httpBody = try? encoder.encode(friend)
            
            let (_,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if(httpResponse.statusCode == 200){
                return
            }
            else{
                print("accept friendship \(httpResponse.statusCode) error")
                throw URLError(.badServerResponse)
            }
            
        }
    }
    
}
