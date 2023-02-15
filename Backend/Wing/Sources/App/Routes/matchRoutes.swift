//
//  matchRoutes.swift
//  
//
//  Created by Allie Griffin on 2022-12-22.
//

import FluentPostgresDriver
import Vapor
import Models
import CoreLocation

let userCalendar = Calendar.current

func matchRoutes(_ app: Application) throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    //Create Swipe Record
    app.post("swipe"){ req async throws -> Bool in
        let currRecord = try req.content.decode(Swipe.self)
        let lowerSId = UUID(String(currRecord.swiperId).lowercased())!
        let lowerPId = UUID(String(currRecord.prospectId).lowercased())!
        
        let existingRecord = try await Swipe.query(on: req.db) //see if any record exists where current prospect has swiped on current swiper
                .filter(\.$swiperId == lowerPId)
                .filter(\.$prospectId == lowerSId)
                .first()
        do {
            if(existingRecord == nil){ //no record exists, create one
                let record = Swipe(swiperId: lowerSId, //force lowercase IDs for consistency
                                   prospectId: lowerPId,
                                   type: currRecord.type,
                                   createdAt: Date())
                try await record.create(on: req.db)
                return false //no match
            }
            
            let id = existingRecord?.id!
            let lowerId = UUID(String(id!).lowercased())!
            
            //a record did exist between the two users
            if(existingRecord?.type != 2 && currRecord.type != 2){
                //both users swiped yes (on thier own or through wing) create a match record and delete swipe record
                let matchRecord: Match
                if(existingRecord?.type == 3 || currRecord.type == 3){
                    matchRecord = Match(firstUserId: lowerSId, secondUserId: lowerPId, type: 2) //via wing
                } else {
                    matchRecord = Match(firstUserId: lowerSId, secondUserId: lowerPId, type: 1) //direct
                }
                try await matchRecord.create(on: req.db)
                
                try await Swipe.query(on: req.db)
                    .filter(\.$id == lowerId)
                    .delete()
                
                return true
                
            } else {
                
                //update existing record to a dislike
                try await Swipe.query(on: req.db)
                    .set(\.$type, to: 2)
                    .filter(\.$id == lowerId)
                    .update()
                
                return false
            }
            
        } catch {
            if(error.localizedDescription.contains("swipes_swiper_id_fkey")){
                throw Error.notFoundwID("user", lowerSId)
            } else if(error.localizedDescription.contains("swipes_prospect_id_fkey")){
                throw Error.notFoundwID("user", lowerPId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to update record: \(error)")
            }
        }
    }
    
    //unmatch given both user IDs
    app.post("unmatch",":id1",":id2"){ req async throws -> Response in
        //delete match record
        guard let id1 = UUID(req.parameters.get("id1")!.lowercased())
        else{
            throw Error.nilId
        }
        
        guard let id2 = UUID(req.parameters.get("id2")!.lowercased())
        else{
            throw Error.nilId
        }
    
        try await Match.query(on: req.db)
            .filter(\.$firstUserId == id1)
            .filter(\.$secondUserId == id2)
            .delete()
        
        try await Match.query(on: req.db)
            .filter(\.$firstUserId == id2)
            .filter(\.$secondUserId == id1)
            .delete()
        
        return Response(status: .accepted)
    }
    
    
    //get all prospects profileIDs
    app.get("prospects", ":userId"){ req async throws -> [UUID] in
        guard let userId = UUID(req.parameters.get("userId")!.lowercased())
        else {
            throw Error.nilId
        }
        
        //get profile of current user
        guard let swiperProfile = try await Profile.query(on: req.db)
            .filter(\.$userId == userId)
            .first() //Will throw error if no User is found
        else {
            throw Error.profileNotFound
        }
        
        //get invalid userIDs
        var invalids = [userId] //initally just current swiper is invalid
        invalids += try await Swipe.query(on: req.db) //currently in swipes
            .filter(\.$swiperId == userId)
            .all(\.$prospectId)
        
        invalids += try await Block.query(on: req.db) //currently in blocks
            .filter(\.$blockedById == userId)
            .all(\.$blockedUserId)
        
        invalids += try await Match.query(on: req.db) //currently in matches as user 1
            .filter(\.$firstUserId == userId)
            .all(\.$secondUserId)
        
        invalids += try await Match.query(on: req.db) //currently in matches as user 2
            .filter(\.$secondUserId == userId)
            .all(\.$firstUserId)
        
        let prospects: [UUID] //initially empty array
        var prospectsInRange: [UUID] = []
        let maxBirthdate = userCalendar.date(byAdding: .year, value: -Int(swiperProfile.minAge), to: Date())!
        let minBirthdate = userCalendar.date(byAdding: .year, value: -Int(swiperProfile.maxAge), to: Date())!
        let userLocation = CLLocation(latitude: swiperProfile.currLatitude, longitude: swiperProfile.currLongitude)
        
        if(swiperProfile.preference == 3){ //do not check gender in req (pref == any)
            prospects = try await Profile.query(on: req.db)
                .filter(\.$userId !~ invalids)
                .filter(\.$birthdate <= maxBirthdate)
                .filter(\.$birthdate >= minBirthdate)
                .all(\.$id)
        } else {
            prospects = try await Profile.query(on: req.db)
                .filter(\.$userId !~ invalids)
                .filter(\.$gender == swiperProfile.preference)
                .filter(\.$birthdate <= maxBirthdate)
                .filter(\.$birthdate >= minBirthdate)
                .all(\.$id)
 
        }
        
        for prospect in prospects {
            let profile = try await Profile.query(on: req.db)
                .filter(\.$id == prospect)
                .first()
            
            let prospectLocation = CLLocation(latitude: profile!.currLatitude, longitude: profile!.currLongitude)
            let distancekm = userLocation.distance(from: prospectLocation) / 1000.00
            
            if(Int(distancekm) <= swiperProfile.maxDistance){
                prospectsInRange.append(prospect)
            }
        }
        
        return prospectsInRange //returns empty array if no prospects
    }
    
    
    
}
