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
    var promptId: UUID?
    
    @Field(key: "prompt_text")
    var promptText: String
    
    init(){
        
    }
    
    init(promptId: UUID? = nil, promptText: String){
        self.promptId = promptId
        self.promptText = promptText
    }
    
}
