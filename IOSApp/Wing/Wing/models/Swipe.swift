//
//  Swipe.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Swipe: Codable{

    var id: UUID?
    var swiperId: UUID?
    var prospectId: UUID?
    var type: Int16?
    var createdAt: Date?

    init(id: UUID? = nil, swiperId: UUID? = nil, prospectId: UUID? = nil, type: Int16? = nil, createdAt: Date? = nil){
        self.id = id
        self.swiperId = swiperId
        self.prospectId = prospectId
        self.type = type
        self.createdAt = createdAt //probably will change to get date/time of initialization
    }
    
}
