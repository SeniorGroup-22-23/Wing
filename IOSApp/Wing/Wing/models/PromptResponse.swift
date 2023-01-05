//
//  PromptResponse.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct PromptResponse: Codable {
 
    var id: UUID?
    var userId: UUID
    var promptId: UUID
    var responseText: String
    
    init(id: UUID? = nil, userId: UUID, promptId: UUID, responseText: String){
        self.id = id
        self.userId = userId
        self.promptId = promptId
        self.responseText = responseText
    }
}

