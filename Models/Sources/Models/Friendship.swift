//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-31.
//

import Vapor
import Fluent

public final class Friendship: Model, Content{
    
    public static let schema = "friendships"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "requester")
    public var requester: UUID
    
    @Field(key: "respondent")
    public var respondent: UUID
    
    // 1 = pending
    // 2 = approved
    @Field(key: "status")
    public var status: Int

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, requester: UUID, respondent: UUID, status: Int){
        self.id = id
        self.requester = requester
        self.respondent = respondent
        self.status = status

        
    }
}

