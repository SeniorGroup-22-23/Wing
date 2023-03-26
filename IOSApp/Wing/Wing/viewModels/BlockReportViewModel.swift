//
//  BlockReportViewModel.swift
//  Wing
//
//  Created by Allie Griffin on 2023-03-08.
//

import Foundation
import SwiftUI


class BlockReportViewModel: ObservableObject{
    
    @ObservedObject var SignupModel: SignupViewModel = .method //To use data collected in sign up view model
    static var method : BlockReportViewModel = BlockReportViewModel()
    
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
            
        let blockUserBody = Block(blockedUserId: blockedUserId, blockedById: SignupModel.user.id, reported: reported, issue: issue)
        
        urlRequest.httpBody = try? JSONEncoder().encode(blockUserBody)

        let (_,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else { return }

        if(httpResponse.statusCode != 200){ //no behavior on 200 response, continue operation
            print("block \(httpResponse.statusCode) error")
            throw URLError(.badServerResponse)
        }
    }
}
