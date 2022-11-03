//
//  Message.swift
//  
//
//  Created by Courtney Perreault on 2022-10-31.
//
import Vapor
import Fluent

public final class Message: Model, Content{
    
    public static let schema = "messages"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "sender_id")
    public var requesterId: UUID
    
    @Field(key: "recipient_id")
    public var respondentId: UUID
    
    @Field(key: "status")
    public var status: Int
    
    @Field(key: "sent_at")
    public var sentAt: Date
    

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, sendId: UUID, recipientId: UUID, status: Int, sentAt: Date){
        
        self.id = id
        self.requesterId = requesterId
        self.respondentId = respondentId
        self.status = status
        self.sentAt = sentAt

        
    }
}

