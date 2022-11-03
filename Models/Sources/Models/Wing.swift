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
    
    @Field(key: "sender_id")
    public var senderId: UUID
    
    @Field(key: "recipient_id")
    public var recipientId: UUID
    
    @Field(key: "prospect_id")
    public var prospectId: UUID
    
    // 1 = pending
    // 2 = liked, send to swipe table, keep record
    // send to swipe table if disliked, delete record
    @Field(key: "status")
    public var status: Int
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, senderId: UUID, recipientId: UUID, prospectId: UUID, status: Int){
        
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.prospectId = prospectId
        self.status = status
        
    }
}
