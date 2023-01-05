//
//  Wing.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Wing: Codable{
    
    var id: UUID?
    var senderId: UUID
    var recipientId: UUID
    var prospectId: UUID
    var status: Int16
    
    init(id: UUID? = nil, senderId: UUID, recipientId: UUID, prospectId: UUID, status: Int16){
        self.id = id
        self.senderId = senderId
        self.recipientId = recipientId
        self.prospectId = prospectId
        self.status = status
    }
}
