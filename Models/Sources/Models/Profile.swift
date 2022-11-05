//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Vapor
import Fluent

public final class Profile: Model, Content{
    
    public static let schema = "profile"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "user_id:")
    public var userId: UUID
    
    @Field(key: "name")
    public var name: String
    
    @Field(key: "birthdate")
    public var birthdate: Date
    
    @Field(key: "occupation")
    public var occupation: String
    
    @Field(key: "bio")
    public var bio: String
    
    // 1 = male
    // 2 = female
    // 3 = other
    @Field(key: "gender")
    public var gender: Int
    
    // 1 = men
    // 2 = women
    // 3 = everyone
    @Field(key: "preference")
    public var preference: Int
    
    @Field(key: "min_age")
    public var minAge: Int
    
    @Field(key: "max_age")
    public var maxAge: Int
    
    // in km
    @Field(key: "max_distance")
    public var maxDistance: Int
    
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, userId: UUID, name: String, birthdate: Date, bio: String, gender: Int,
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
