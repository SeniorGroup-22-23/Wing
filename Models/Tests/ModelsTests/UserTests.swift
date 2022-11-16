//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-15.
//

import XCTest
@testable import Models

final class UserTests: XCTestCase {
    func initilaizeUserTest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        var testData: [String: String] = ["username":"testUser123", "password":"testPassword123!", "phone":"5062325003"]
        let testUser = try decode(testData)
        let testUser = User("testUser123", "testPassword123!", )
        XCTAssertEqual(Models().text, "Hello, World!")
    }
}

