//
//  ProfileTests.swift
//  
//
//  Created by Courtney Perreault on 2022-11-21.
//

import XCTest
@testable import Models

final class ProfileTests: XCTestCase {
    
    func testInitProfile() throws {
        
        let userId = UUID()
        let name = "Jane"
        let birthdate = Date()
        let occupation = "Student"
        let bio = "Just your average software engineering student"
        let female = Int16(2)
        let men = Int16(1)
        let minAge = Int16(20)
        let maxAge = Int16(26)
        let maxDistance = Int16(45)
        let currLatitude = Double(16.6)
        let currLongitude = Double(17.7)
        
        
        let profile = Profile(id: nil, userId: userId, name: name, birthdate: birthdate, occupation: occupation, bio: bio, gender: 2, preference: 1, minAge: minAge, maxAge: maxAge, maxDistance: maxDistance, currLatitude: currLatitude, currLongitude: currLongitude)

        
        XCTAssertNil(profile.id)
        
        XCTAssertEqual(profile.userId, userId)
        XCTAssert((profile.userId as Any) is UUID)
        
        XCTAssertEqual(profile.name, name)
        XCTAssert((profile.name as Any) is String)

        
        XCTAssertEqual(profile.birthdate, birthdate)
        XCTAssert((profile.birthdate as Any) is Date)
        
        XCTAssertEqual(profile.occupation, occupation)
        XCTAssert((profile.occupation as Any) is String)
        
        XCTAssertEqual(profile.bio, bio)
        XCTAssert((profile.bio as Any) is String)
        
        XCTAssertEqual(profile.gender, female)
        XCTAssert((profile.gender as Any) is Int16)
        
        XCTAssertEqual(profile.preference, men)
        XCTAssert((profile.preference as Any) is Int16)
        
        XCTAssertEqual(profile.minAge, minAge)
        XCTAssert((profile.minAge as Any) is Int16)
        
        XCTAssertEqual(profile.maxAge, maxAge)
        XCTAssert((profile.maxAge as Any) is Int16)
        
        XCTAssertEqual(profile.maxDistance, maxDistance)
        XCTAssert((profile.maxDistance as Any) is Int16)
        
        XCTAssertEqual(profile.currLatitude, currLatitude)
        XCTAssert((profile.currLatitude as Any) is Double)
        
        XCTAssertEqual(profile.currLongitude, currLongitude)
        XCTAssert((profile.currLongitude as Any) is Double)
    
        
    }
    
}
