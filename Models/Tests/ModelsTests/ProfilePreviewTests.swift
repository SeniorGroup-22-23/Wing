//
//  ProfilePreviewTests.swift
//  
//
//  Created by Courtney Perreault on 2022-12-17.
//

import XCTest
@testable import Models


final class ProfilePreviewTests: XCTestCase {
    
    func testInitProfilePreview() throws {
        
        let userId = UUID()
        let username = "jjetta"
        let name = "Joey"
        let primaryPhoto: Data = Data()

        
        
        let profilePreview = ProfilePreview(userId: userId, username: username, name: name, primaryPhoto: primaryPhoto)
        
        XCTAssertNil(profilePreview.id)
        
        XCTAssertEqual(profilePreview.userId, userId)
        XCTAssert((profilePreview.userId as Any) is UUID)
        
        XCTAssertEqual(profilePreview.username, username)
        XCTAssert((profilePreview.username as Any) is String)
        
        XCTAssertEqual(profilePreview.name, name)
        XCTAssert((profilePreview.name as Any) is String)
        
        XCTAssertEqual(profilePreview.primaryPhoto, primaryPhoto)
        XCTAssert((profilePreview.primaryPhoto as Any) is Data)

        
        
    }
    
}
