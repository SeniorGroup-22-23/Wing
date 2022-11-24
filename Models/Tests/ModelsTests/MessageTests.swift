//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models


final class MessageTests: XCTestCase{
    
    
    func testInitMessage() throws {
        
        let senderId = UUID()
        let recipientId = UUID()
        let content = "Hey, how are you doing?"
        let read = Int16(2)
    
        
        let message = Message(senderId: senderId, recipientId: recipientId, content: content, status: 2)
        
        XCTAssertEqual(message.senderId, senderId)
        XCTAssert((message.senderId as Any) is UUID)
        
        XCTAssertEqual(message.recipientId, recipientId)
        XCTAssert((message.recipientId as Any) is UUID)
        
        XCTAssertEqual(message.content, content)
        XCTAssert((message.content as Any) is String)
        
        XCTAssertEqual(message.status, read)
        XCTAssert((message.status as Any) is Int16)
        
        
    }
}
