//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-20.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver


final class Prompt: Model {
    
    static let schema = "prompts"
    
    @ID(key: .id)
    var promptId: UUID?
    
    @Field(key: "prompt_text")
    var promptText: String
    
    init()
    
    init(promptId: UUID? = nil, promptText: String){
        self.promptId = promptId
        self.promptText = String
    }
}
