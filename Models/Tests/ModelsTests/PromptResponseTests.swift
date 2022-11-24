//
//  PromptResponseTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class PromptResponseTests: XCTest {
    
    func testInitPromptResponseTests(){
        
        let userId = UUID()
        let promptId = UUID()
        let responseText = "cheese"
        
        let promptResponse = PromptResponse(userId: userId, promptId: promptId, responseText: responseText)
        
        XCTAssertNil(promptResponse.id)
        
        XCTAssertEqual(promptResponse.userId, userId)
        XCTAssert((promptResponse.userId as Any) is UUID)
        
        XCTAssertEqual(promptResponse.promptId, promptId)
        XCTAssert((promptResponse.promptId as Any) is UUID)
        
        XCTAssertEqual(promptResponse.responseText, responseText)
        XCTAssert((promptResponse.responseText as Any) is String)
        
    }
}
