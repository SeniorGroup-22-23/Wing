//
//  Block.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Block: Codable{
    
    var id: UUID?
    var blockedUserId: UUID?
    var blockedById: UUID?
    var reported: Bool?
    var issue: Int16?
    
    init(id: UUID? = nil, blockedUserId: UUID? = nil, blockedById: UUID? = nil, reported: Bool? = nil, issue: Int16? = nil){
        self.id  = id
        self.blockedUserId = blockedUserId
        self.blockedById = blockedById
        self.reported = reported
        self.issue = issue
    }
}
