//
//  PromptTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class PromptTests: XCTestCase {
    
    func testInitPrompt() throws {
        
        let promptText = "What is your favourite pizza topping?"
        
        let prompt = Prompt(promptText: promptText)
        
        XCTAssertNil(prompt.id)
        
        XCTAssertEqual(prompt.promptText, promptText)
        XCTAssert((prompt.promptText as Any) is String)
                    
    }
}
