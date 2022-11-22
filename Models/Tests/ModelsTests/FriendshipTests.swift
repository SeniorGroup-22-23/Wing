//
//  FriendshipTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class FriendshipTests: XCTestCase {
    
    func testInitFriendship() throws {
        
        let requesterId = UUID()
        let respondentId = UUID()
        let approved = Int16(2)
       
        let friendship = Friendship(requesterId: requesterId, respondentId: respondentId, status: 2)
        
        
        XCTAssertNil(friendship.id)
        
        XCTAssertEqual(friendship.requesterId, requesterId)
        XCTAssert((friendship.requesterId as Any) is UUID)
        
        XCTAssertEqual(friendship.respondentId, respondentId)
        XCTAssert((friendship.respondentId as Any) is UUID)
        
        XCTAssertEqual(friendship.status, approved)
        XCTAssert((friendship.status as Any) is Int16)
        
     
        
        
    }
}

