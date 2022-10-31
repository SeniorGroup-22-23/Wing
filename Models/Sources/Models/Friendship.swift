//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-31.
//

import Vapor
import Fluent

final class Friendship: Model, Content{
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "requester")
    var username: String
    
    @Field(key: "respondent")
    var password: String
    
    @Field(key: "status")
    var status: Int

    
    init(){
        
    }
    
    init(id: UUID? = nil, username: String, password: String, phone: String, email: String){
        self.id = id
        self.username = username
        self.password = password
        self.status = status

        
    }
}

