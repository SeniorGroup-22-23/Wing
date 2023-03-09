//
//  BlockReportViewModel.swift
//  Wing
//
//  Created by Allie Griffin on 2023-03-08.
//

import Foundation
import SwiftUI


class BlockReportViewModel: ObservableObject{
    
    static var method : BlockReportViewModel = BlockReportViewModel()
    
    @Published var id: UUID = UUID(uuidString: "1d6810d1-812c-4c25-a621-3fb111ac901b")! //TODO: changes to have the current users id
    @Published var issue: Int16 = 0
    
    var baseURL = "http://127.0.0.1:8080"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(){
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }
    
    
    func setMethod(){
        BlockReportViewModel.method = BlockReportViewModel()
    }
    
    
    func blockUser(blockedUserId: UUID, reported: Bool, issue: Int16) async throws {
        let url = URL(string: baseURL + "/block")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let blockUserBody = BlockUserBody(blockedUserId: blockedUserId, blockedById: id, reported: reported, issue: issue)
        
        urlRequest.httpBody = try? JSONEncoder().encode(blockUserBody)

        let (_,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }

        if(httpResponse.statusCode != 200){ //no behavior on 200 response, continue operation
            print("block \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
}

//Request Body for POST Block
//Used to encode to JSON
struct BlockUserBody: Codable{
    
    var blockedUserId: UUID?
    var blockedById: UUID?
    var reported: Bool?
    var issue: Int16?
    

    init(blockedUserId: UUID? = nil, blockedById: UUID? = nil, reported: Bool? = nil, issue: Int16? = nil){
        self.blockedUserId = blockedUserId
        self.blockedById = blockedById
        self.reported = reported
        self.issue = issue
    }
}
