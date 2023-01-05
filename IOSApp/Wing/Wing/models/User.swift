//
//  User.swift
//  Wing
//
//  Created by Bryn Haines on 2022-12-26.
//

import Foundation

struct User: Codable{
    
    var id: UUID
    var username: String?
    var password: String?
    var phone: String?
    var email: String?
    

    init(username: String? = nil, password: String? = nil, phone: String? = nil, email: String? = nil){
        self.id = UUID()
        self.username = username
        self.password = password
        self.phone = phone
        self.email = email

    }
    
    init(id: UUID, username: String, password: String, phone: String, email: String){
        self.id = id
        self.username = username
        self.password = password
        self.phone = phone
        self.email = email

    }
}

