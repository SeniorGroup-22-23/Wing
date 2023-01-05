//
//  Swipe.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Swipe: Codable{

    var id: UUID?
    var swiperId: UUID
    var prospectId: UUID
    var type: Int16 //would we rather have integer codes?
    var createdAt: Date? // TBD

    init(id: UUID? = nil, swiperId: UUID, prospectId: UUID, type: Int16, createdAt: Date? = nil){
        self.id = id
        self.swiperId = swiperId
        self.prospectId = prospectId
        self.type = type
        self.createdAt = createdAt //probably will change to get date/time of initialization
    }
    
}
