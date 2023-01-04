//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-03.
//

import Vapor
import Fluent

public final class Photo: Model, Content{
    
    public static let schema = "photos"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "user_id")
    public var userId: UUID
    
    @Field(key: "photo")
    public var photo: Data
   
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, userId: UUID, photo: Data){
        
        self.id = id
        self.userId = userId
        self.photo = photo
        
    }
}

