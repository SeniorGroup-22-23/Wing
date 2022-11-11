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
    
    @Field(key: "blocked_user")
    public var blockedUser: UUID
    
    @Field(key: "blocked_by")
    public var blockedBy: UUID
    
    @Field(key: "reported")
    public var reported: Bool
    
    @Field(key: "issue")
    public var issue: Int
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, blockedUser: UUID, blockedBy: UUID, reported: Bool, issue: Int){
        self.id  = id
        self.blockedUser = blockedUser
        self.blockedBy = blockedBy
        self.reported = reported
        self.issue = issue
    }
}
