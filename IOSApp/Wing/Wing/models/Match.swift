//
//  Match.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Match: Codable{
    
    var id: UUID?
    var firstUserId: UUID?
    var secondUserId: UUID?
    var type: Int16?

    init(id: UUID? = nil, firstUserId: UUID? = nil, secondUserId: UUID? = nil, type: Int16? = nil){
        self.id = id
        self.firstUserId = firstUserId
        self.secondUserId = secondUserId
        self.type = type
    }
}

