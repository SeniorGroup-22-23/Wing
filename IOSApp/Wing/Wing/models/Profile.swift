//
//  Profile.swift
//  Wing
//
//  Created by Bryn Haines on 2022-12-29.
//

import Foundation

struct Profile: Codable{
    
    var id: UUID?
    var userId: UUID?
    var name: String?
    var birthdate: Date?
    var occupation: String?
    var bio: String?
    var gender: Int16?
    var preference: Int16?
    var minAge: Int16?
    var maxAge: Int16?
    var maxDistance: Int16?
    
    
    init(id: UUID? = nil, userId: UUID? = nil, name: String? = nil, birthdate: Date? = nil, occupation: String? = nil, bio: String? = nil, gender: Int16? = nil, preference: Int16? = nil, minAge: Int16? = nil, maxAge: Int16? = nil, maxDistance: Int16? = nil){
        
        self.id = id
        self.userId = userId
        self.name = name
        self.birthdate = birthdate
        self.occupation = occupation
        self.bio = bio
        self.gender = gender
        self.preference = preference
        self.minAge = minAge
        self.maxAge = maxAge
        self.maxDistance = maxDistance
    }
}
