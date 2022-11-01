//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Vapor
import Fluent

public final class User: Model, Content{
    
    public static let schema = "users"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "username")
    public var username: String
    
    @Field(key: "password")
    public var password: String
    
    @Field(key: "phone")
    public var phone: String
    
    @Field(key: "email")
    public var email: String
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, username: String, password: String, phone: String, email: String){
        self.id = id
        self.username = username
        self.password = password
        self.phone = phone
        self.email = email
        
    }
}
