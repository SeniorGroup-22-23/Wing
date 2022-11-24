//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-15.
//

import XCTest
@testable import Models

final class UserTests: XCTestCase {
    
    func testInitUser() throws {
        
        let user = User(id: nil, username: "janeDoe", password: "testPassword",
                         phone: "5069871234", email: "janeDoe@hotmail.com")
        
        XCTAssertEqual(user.username, "janeDoe")
        XCTAssert((user.username as Any) is String)
        
        XCTAssertEqual(user.password, "testPassword")
        XCTAssert((user.password as Any) is String)
        
        XCTAssertEqual(user.phone, "5069871234")
        XCTAssert((user.phone as Any) is String)
        
        XCTAssertEqual(user.email, "janeDoe@hotmail.com")
        XCTAssert((user.email as Any) is String)
        
        XCTAssertNil(user.id)
    }
    
}
