//
//  ProfilePreview.swift
//  
//
//  Created by Courtney Perreault on 2022-12-16.
//

import Vapor
import Fluent

public final class ProfilePreview: Model, Content{
    
    public static let schema = "profile_previews"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "user_id")
    public var userId: UUID
    
    @Field(key: "username")
    public var username: String
    
    @Field(key: "name")
    public var name: String
    
    @Field(key: "primary_photo")
    public var primaryPhoto: Data
    

    
    public init(){
        
    }
    
    public init(id: UUID? = nil, userId: UUID, username: String, name: String, primaryPhoto: Data){
        self.id = id
        self.userId = userId
        self.username = username
        self.name = name
        self.primaryPhoto = primaryPhoto
    }
    
}
