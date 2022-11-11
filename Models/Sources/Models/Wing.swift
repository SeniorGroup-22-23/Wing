//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Vapor
import Fluent

public final class Wing: Model, Content{
    
    public static let schema = "wings"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "sender")
    public var sender: UUID
    
    @Field(key: "recipient")
    public var recipient: UUID
    
    @Field(key: "prospect")
    public var prospect: UUID
    
    // 1 = pending
    // 2 = liked, send to swipe table, keep record
    // send to swipe table if disliked, delete record
    @Field(key: "status")
    public var status: Int
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, sender: UUID, recipient: UUID, prospect: UUID, status: Int){
        
        self.id = id
        self.sender = sender
        self.recipient = recipient
        self.prospect = prospect
        self.status = status
        
    }
}
