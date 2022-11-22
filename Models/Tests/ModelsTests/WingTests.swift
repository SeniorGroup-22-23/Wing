//
//  WingTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class WingTests{
    
    func testInitWing() throws {
        
        let senderId = UUID()
        let recipientId = UUID()
        let prospectId = UUID()
        let pending = Int16(1)
        
        let wing = Wing(senderId: senderId, recipientId: recipientId, prospectId: prospectId, status: 1)
        
        XCTAssertNil(wing.id)
        
        XCTAssertEqual(wing.senderId, senderId)
        XCTAssert((wing.senderId as Any) is UUID)
        
        XCTAssertEqual(wing.recipientId, recipientId)
        XCTAssert((wing.recipientId as Any) is UUID)
        
        XCTAssertEqual(wing.prospectId, prospectId)
        XCTAssert((wing.prospectId as Any) is UUID)
        
        XCTAssertEqual(wing.status, pending)
        XCTAssert((wing.status as Any) is Int16)
        
    }
}
