//
//  Photo.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Photo: Codable{
    
    var id: UUID?
    var userId: UUID?
    var photo: [UInt8]?
    
    init(id: UUID? = nil, userId: UUID? = nil, photo: [UInt8]? = nil){
        self.id = id
        self.userId = userId
        self.photo = photo
    }
}

