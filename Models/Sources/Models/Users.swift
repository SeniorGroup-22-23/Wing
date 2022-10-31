//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Vapor
import Fluent

final class Users: Model, Content{
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "phone")
    var phone: String
    
    @Field(key: "email")
    var email: String
    
    init(){
        
    }
    
    init(id: UUID? = nil, username: String, password: String, phone: String, email: String){
        self.id = id
        self.username = username
        self.password = password
        self.phone = phone
        self.email = email
        
    }
}
