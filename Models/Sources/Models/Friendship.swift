//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-31.
//

import Vapor
import Fluent

final class Friendship: Model, Content{
    
    static let schema = "friendships"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "requester_id")
    var requesterId: UUID
    
    @Field(key: "respondent_id")
    var respondentId: UUID
    
    @Field(key: "status")
    var status: Int

    
    init(){
        
    }
    
    init(id: UUID? = nil, requesterId: UUID, respondentId: UUID, status: Int){
        self.id = id
        self.requesterId = requesterId
        self.respondentId = respondentId
        self.status = status

        
    }
}

