//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Fluent
import Vapor


final class PromptResponse: Model, Content {
    
    static let schema = "PromptResponses"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "userId")
    var userId: UUID?
    
    @Field(key: "promptId")
    var promptId: UUID?
    
    @Field(key: "response_text")
    var responseText: String
    
    init(){
        
    }
    
    init(id: UUID? = nil, userId: UUID?, promptId: UUID?, responseText: String){
        self.id = id
        self.userId = userId
        self.promptId = promptId
        self.responseText = responseText
    }
}

