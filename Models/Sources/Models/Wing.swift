//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Vapor
import Fluent

final class Wing: Model, Content{
    
    static let schema = "wings"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "sender_id")
    var senderId: UUID
    
    @Field(key: "recipient_id")
    var recipientId: UUID
    
    @Field(key: "prospect_id")
    var prospectId: UUID
    
    @Field(key: "status")
    var status: Int
    
    init(){
        
    }
    
    init(id: UUID? = nil, senderId: UUID, recipientId: UUID, prospectId: UUID, status: Int){
        
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.prospectId = prospectId
        self.status = status
        
    }
}
