//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Vapor
import Fluent

public final class Match: Model, Content{
    
    public static let schema = "matches"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "user1_id")
    public var user1Id: UUID
    
    @Field(key: "user2_id")
    public var user2Id: UUID
    
    // 1 = direct
    // 2 = via wing
    @Field(key: "type")
    public var type: Int
    
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, user1Id: UUID, user2Id: UUID, type: Int){
        self.id = id
        self.user1Id = user1Id
        self.user2Id = user2Id
        self.type = type
        
    }
}

