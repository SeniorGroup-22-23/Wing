//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//


import Fluent
import Vapor


final class PromptResponse: Model, Content {
    
    static let schema = "PromptResponses"
    
    //PK generated by DB
    @ID(key: .id)
    var id: UUID?
    
    //FK referencing user who responded to prompt
    @Field(key: "userId")
    var userId: UUID
    
    //FK referencing prompt being responded to
    @Field(key: "promptId")
    var promptId: UUID
    
    //The textual string representing the response provided by the user
    @Field(key: "response_text")
    var responseText: String
    
    init(){
        
    }
    
    init(id: UUID? = nil, userId: UUID, promptId: UUID, responseText: String){
        self.id = id
        self.userId = userId
        self.promptId = promptId
        self.responseText = responseText
    }
}
