//
//  ProfilePreview.swift
//
//
//  Created by Courtney Perreault on 2022-12-16.
//

import Foundation

struct ProfilePreview: Codable, Identifiable{
    
    var id: UUID?
    var userId: UUID?
    var username: String?
    var name: String?
    var primaryPhoto: Data?
    
    init(id: UUID? = nil, userId: UUID? = nil, username: String? = nil, name: String? = nil, primaryPhoto: Data? = nil){
        self.id = id
        self.userId = userId
        self.username = username
        self.name = name
        self.primaryPhoto = primaryPhoto
    }
    
}
