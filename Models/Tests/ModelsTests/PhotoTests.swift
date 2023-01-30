//
//  PhotoTests.swift
//
//
//  Created by Courtney Perreault on 2022-01-30.
//

import XCTest
@testable import Models


final class PhotoTests: XCTestCase {
    
    func testInitPhoto() throws {
        
        let userId = UUID()
        let photoData = Data()
        let index = Int16(0)

        
        
        let photo = Photo(userId: userId, photo: photoData, index: index)
        
        XCTAssertNil(photo.id)
        
        XCTAssertEqual(photo.userId, userId)
        XCTAssert((photo.userId as Any) is UUID)
        
        XCTAssertEqual(photo.photo, photoData)
        XCTAssert((photo.photo as Any) is Data)
        
        XCTAssertEqual(photo.index, index)
        XCTAssert((photo.index as Any) is Int16)
        

        
        
    }
    
}
