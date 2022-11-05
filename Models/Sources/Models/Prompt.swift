//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//
import Fluent
import Vapor

public final class Prompt: Model, Content{

    
    public static let schema = "prompts"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "prompt_text")
    public var promptText: String
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, promptText: String){
        self.id = id
        self.promptText = promptText
    }
    
}
