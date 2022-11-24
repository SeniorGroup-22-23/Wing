//
//  SwipeTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class SwipeTests: XCTestCase {
    
    func testInitSwipe() throws{
        
        let swiperId = UUID()
        let prospectId = UUID()
        let dislike = Int16(2)
        
        let swipe = Swipe(swiperId: swiperId, prospectId: prospectId, type: dislike)
        
        XCTAssertNil(swipe.id)
        
        XCTAssertEqual(swipe.swiperId, swiperId)
        XCTAssert((swipe.swiperId as Any) is UUID)
        
        XCTAssertEqual(swipe.prospectId, prospectId)
        XCTAssert((swipe.prospectId as Any) is UUID)
        
        XCTAssertEqual(swipe.type, dislike)
        XCTAssert((swipe.type as Any) is Int16)
        
    }
}
