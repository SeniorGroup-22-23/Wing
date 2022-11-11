//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Vapor
import Fluent

public final class Match: Model, Content{
    
    public static let schema = "matches"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "first_user")
    public var firstUser: UUID
    
    @Field(key: "second_ser")
    public var secondUser: UUID
    
    // 1 = direct
    // 2 = via wing
    @Field(key: "type")
    public var type: Int
    
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, firstUser: UUID, secondUser: UUID, type: Int){
        self.id = id
        self.firstUser = firstUser
        self.secondUser = secondUser
        self.type = type
        
    }
}

