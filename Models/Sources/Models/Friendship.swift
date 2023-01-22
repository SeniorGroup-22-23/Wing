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
    
    @Field(key: "requester_id")
    public var requesterId: UUID
    
    @Field(key: "respondent_id")
    public var respondentId: UUID
    
    // 1 = pending
    // 2 = approved
    // 3 = declined
    @Field(key: "status")
    public var status: Int16

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, requesterId: UUID, respondentId: UUID, status: Int16){
        self.id = id
        self.requesterId = requesterId
        self.respondentId = respondentId
        self.status = status
        
    }
}

