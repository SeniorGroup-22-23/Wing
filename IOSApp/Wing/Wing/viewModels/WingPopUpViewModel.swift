//
//  WingPopupViewModel.swift
//  Wing
//
//  Created by Allie Griffin on 2023-03-13.
//

import Foundation
import SwiftUI


class WingPopupViewModel: ObservableObject{
    
    @ObservedObject var SignupModel: SignupViewModel = .method
    static var method : WingPopupViewModel = WingPopupViewModel()
    
    @Published var friendProfilePreviews: [ProfilePreview] = []
    @Published var friendProfilePreviewIds: [UUID] = []
    @Published var noFriends = false
    
    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func setMethod(){
        WingPopupViewModel.method = WingPopupViewModel()
    }
    
    func getFriends() async throws {

        //let url = URL(string: baseURL + "/friends/\(String(describing: SignupModel.user.id))")! //TODO: keep this one
        let url = URL(string: baseURL + "/friends/1d6810d1-812c-4c25-a621-3fb111ac901b")! //TODO: remove (this was just for testing)

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        if(httpResponse.statusCode == 200){
            let decodedIDs = try JSONDecoder().decode([UUID].self, from: data)
            self.friendProfilePreviewIds = decodedIDs
            
        } else {
            print("Get friends \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    
    func getProfilePreviews() async throws {
    
        self.friendProfilePreviews = [] //empty each time
        
        for profilePreviewId in self.friendProfilePreviewIds{
            
            let url = URL(string: baseURL + "/profilePreview/id/\(String(describing: profilePreviewId))")!
            
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { continue }
            
            if(httpResponse.statusCode == 200){
                let profilePreview = try JSONDecoder().decode(ProfilePreview.self, from: data)
                self.friendProfilePreviews.append(profilePreview)
            } else {
                print("Profile Preview not found for \(String(describing: profilePreviewId))")
            }
        }
        
        if(self.friendProfilePreviews.isEmpty){
            self.noFriends = true
        } else {
            self.noFriends = false
        }
        
    }
    
    
    func wingUser(prospectId: UUID, recipientId: UUID) async throws {
        
        let url = URL(string: baseURL + "/wing")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let wingBody = Wing(senderId: SignupModel.user.id, recipientId: recipientId, prospectId: prospectId, status: 1) //at this stage status is always 1
        
        urlRequest.httpBody = try? JSONEncoder().encode(wingBody)

        let (_,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }

        if(httpResponse.statusCode != 200){ //no behavior on 200 response, continue operation
            print("post wing \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
        
    }
    
    
}
