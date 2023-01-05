//
//  Message.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Message: Codable{

    var id: UUID?
    var senderId: UUID
    var recipientId: UUID
    var content: String
    var status: Int16
    var sentAt: Date?
    
    init(id: UUID? = nil, senderId: UUID, recipientId: UUID, content: String, status: Int16, sentAt: Date? = nil){
        
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.content = content
        self.status = status
        self.sentAt = sentAt
    }
}
