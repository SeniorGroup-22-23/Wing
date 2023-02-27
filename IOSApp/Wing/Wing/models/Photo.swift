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
    var photo: Data?
    var index: Int16?
    
    init(id: UUID? = nil, userId: UUID? = nil, photo: Data? = nil, index: Int16){
        self.id = id
        self.userId = userId
        self.photo = photo
        self.index = index
    }
}

