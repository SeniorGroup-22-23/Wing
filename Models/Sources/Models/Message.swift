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
    public var senderId: UUID
    
    @Field(key: "recipient_id")
    public var recipientId: UUID
    
    @Field(key: "content")
    public var content: String
    
    // 1 = sent
    // 2 = read
    @Field(key: "status")
    public var status: Int16
    
    @Timestamp(key: "sent_at", on: .create)
    public var sentAt: Date?
    

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, senderId: UUID, recipientId: UUID, content: String, status: Int16, sentAt: Date? = nil){
        
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.content = content
        self.status = status
        self.sentAt = sentAt

        
    }
}

