//
//  Block.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Vapor
import Fluent

public final class Block: Model, Content{
    
    public static let schema = "blocks"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "blocked_user_id")
    public var blockedUserId: UUID
    
    @Field(key: "blocked_by_id")
    public var blockedById: UUID
    
    @Field(key: "reported")
    public var reported: Bool
    
    @Field(key: "issue")
    public var issue: Int16
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, blockedUserId: UUID, blockedById: UUID, reported: Bool, issue: Int16){
        self.id  = id
        self.blockedUserId = blockedUserId
        self.blockedById = blockedById
        self.reported = reported
        self.issue = issue
    }
}
