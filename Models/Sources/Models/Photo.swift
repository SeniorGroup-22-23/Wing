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
    
    @Field(key: "user")
    public var user: UUID
    
    @Field(key: "photo")
    public var photo: [UInt8]
   
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, user: UUID, photo: [UInt8]){
        
        self.id = id
        self.user = user
        self.photo = photo
        
    }
}

