//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//
import Fluent
import Vapor

final class Prompt: Model, Content{

    
    static let schema = "prompts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "prompt_text")
    var promptText: String
    
    init(){
        
    }
    
    init(id: UUID? = nil, promptText: String){
        self.id = id
        self.promptText = promptText
    }
    
}
