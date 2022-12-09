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
    
    @Field(key: "first_user_id")
    public var firstUserId: UUID
    
    @Field(key: "second_user_id")
    public var secondUserId: UUID
    
    // 1 = direct
    // 2 = via wing
    @Field(key: "type")
    public var type: Int16
    
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, firstUserId: UUID, secondUserId: UUID, type: Int16){
        self.id = id
        self.firstUserId = firstUserId
        self.secondUserId = secondUserId
        self.type = type
        
    }
}

