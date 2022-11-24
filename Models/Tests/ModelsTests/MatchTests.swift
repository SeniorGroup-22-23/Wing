//
//  MatchTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class MatchTests: XCTestCase{
    
    func testInitMatch() throws{
        
        let firstUserId = UUID()
        let secondUserId = UUID()
        let direct = Int16(1)
        
        
        let match = Match(id: nil, firstUserId: firstUserId, secondUserId: secondUserId, type: 1)
        
        XCTAssertNil(match.id)
        
        XCTAssertEqual(match.firstUserId, firstUserId)
        XCTAssert((match.firstUserId as Any) is UUID)
        
        XCTAssertEqual(match.secondUserId, secondUserId)
        XCTAssert((match.secondUserId as Any) is UUID)
        
        XCTAssertEqual(match.type, direct)
        XCTAssert((match.type as Any) is Int16)
        
    }
}
