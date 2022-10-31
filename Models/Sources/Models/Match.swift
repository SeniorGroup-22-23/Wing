//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Vapor
import Fluent

final class Match: Model, Content{
    
    static let schema = "matches"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user1_id")
    var user1Id: UUID
    
    @Field(key: "user2_id")
    var user2Id: UUID
    
    @Field(key: "type")
    var type: Int
    
    
    init(){
        
    }
    
    init(id: UUID? = nil, user1Id: UUID, user2Id: UUID, type: Int){
        self.id = id
        self.user1Id = user1Id
        self.user2Id = user2Id
        self.type = type
        
    }
}

