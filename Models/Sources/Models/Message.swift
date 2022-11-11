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
    
    @Field(key: "sender")
    public var sender: UUID
    
    @Field(key: "recipient")
    public var recipient: UUID
    
    @Field(key: "content")
    public var content: String
    
    // 1 = sent
    // 2 = read
    @Field(key: "status")
    public var status: Int
    
    @Field(key: "sent_at")
    public var sentAt: Date
    

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, sender: UUID, recipient: UUID, content: String, status: Int, sentAt: Date){
        
        self.id = id
        self.sender = sender
        self.recipient = recipient
        self.content = content
        self.status = status
        self.sentAt = sentAt

        
    }
}

