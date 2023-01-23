//
//  Friendship.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Friendship: Codable{
    
    var id: UUID?
    var requesterId: UUID?
    var respondentId: UUID?
    var status: Int16?
    
    init(id: UUID? = nil, requesterId: UUID? = nil, respondentId: UUID? = nil, status: Int16? = nil){
        self.id = id
        self.requesterId = requesterId
        self.respondentId = respondentId
        self.status = status
    }
}

