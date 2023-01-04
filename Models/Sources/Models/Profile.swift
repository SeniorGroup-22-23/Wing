//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Vapor
import Fluent

public final class Profile: Model, Content{
    
    public static let schema = "profiles"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "user_id")
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
    public var gender: Int16
    
    // 1 = men
    // 2 = women
    // 3 = everyone
    @Field(key: "preference")
    public var preference: Int16
    
    @Field(key: "min_age")
    public var minAge: Int16
    
    @Field(key: "max_age")
    public var maxAge: Int16
    
    // in km
    @Field(key: "max_distance")
    public var maxDistance: Int16
    
    @Field(key: "curr_latitude")
    public var currLatitude: Double
    
    @Field(key: "curr_longitude")
    public var currLongitude: Double
    
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, userId: UUID, name: String, birthdate: Date, occupation: String, bio: String, gender: Int16,
                preference: Int16, minAge: Int16, maxAge: Int16, maxDistance: Int16, currLatitude: Double, currLongitude: Double){
        
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
        self.currLatitude = currLatitude
        self.currLongitude = currLongitude
        
    }
    
    
}
