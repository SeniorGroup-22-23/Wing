//
//  BlockTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class BlockTests: XCTestCase {
    
    func testInitBlock() throws {
        
        let blockedUserId = UUID()
        let blockedById = UUID()
        let reported = true
        let issue = Int16(3)
        
        let block = Block(id: nil, blockedUserId: blockedUserId, blockedById: blockedById, reported: reported,issue: issue)
        
        XCTAssertNil(block.id)
        
        XCTAssertEqual(block.blockedUserId, blockedUserId)
        XCTAssert((block.blockedUserId as Any) is UUID)
        
        XCTAssertEqual(block.blockedById, blockedById)
        XCTAssert((block.blockedById as Any) is UUID)
        
        XCTAssert(block.reported)
        XCTAssertEqual(block.issue, issue)
        

    }
}

