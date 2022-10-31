//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Vapor
import Fluent

final class Profile: Model, Content{
    
    static let schema = "profile"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_id:")
    var userId: UUID
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "birthdate")
    var birthdate: Date
    
    @Field(key: "occupation")
    var occupation: String
    
    @Field(key: "bio")
    var bio: String
    
    @Field(key: "gender")
    var gender: Int
    
    //put int codes and meanings here
    @Field(key: "preference")
    var preference: Int
    
    @Field(key: "min_age")
    var minAge: Int
    
    @Field(key: "max_age")
    var maxAge: Int
    
    @Field(key: "max_distance")
    var maxDistance: Int
    
    
    init(){
        
    }
    
    init(id: UUID? = nil, userId: UUID, name: String, birthdate: Date, bio: String, gender: Int,
         preference: Int, minAge: Int, maxAge: Int, maxDistance: Int){
        
        self.id = id
        self.userId = userId
        self.name = name
        self.birthdate = birthdate
        self.bio = bio
        self.gender = gender
        self.preference = preference
        self.minAge = minAge
        self.maxAge = maxAge
        self.maxDistance = maxDistance
        
    }
    
    
}
