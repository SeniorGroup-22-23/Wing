//
//  Prompt.swift
//  Wing
//
//  Created by Bryn Haines on 2023-01-04.
//

import Foundation

struct Prompt: Codable{

    var id: UUID?
    var promptText: String

    init(id: UUID? = nil, promptText: String){
        self.id = id
        self.promptText = promptText
    }
    
}
