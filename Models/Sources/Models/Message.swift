//
//  Message.swift
//  
//
//  Created by Courtney Perreault on 2022-10-31.
//
import Vapor
import Fluent

final class Message: Model, Content{
    
    static let schema = "messages"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "sender_id")
    var requesterId: UUID
    
    @Field(key: "recipient_id")
    var respondentId: UUID
    
    @Field(key: "status")
    var status: Int
    
    @Field(key: "sent_at")
    var sentAt: Date
    

    
    init(){
        
    }
    
    init(id: UUID? = nil, sendId: UUID, recipientId: UUID, status: Int, sentAt: Date){
        
        self.id = id
        self.requesterId = requesterId
        self.respondentId = respondentId
        self.status = status
        self.sentAt = sentAt

        
    }
}

