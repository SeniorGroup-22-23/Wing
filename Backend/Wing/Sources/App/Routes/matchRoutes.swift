//
//  matchRoutes.swift
//  
//
//  Created by Allie Griffin on 2022-12-22.
//

import FluentPostgresDriver
import Vapor
import Models

func matchRoutes(_ app: Application) throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    //Create Swipe Record
    //returns true if match was found, false otherwise 
    app.post("swipe"){ req async throws -> Bool in
        let temp = try req.content.decode(Swipe.self)
        let lowerSId = UUID(String(temp.swiperId).lowercased())!
        let lowerPId = UUID(String(temp.prospectId).lowercased())!
        
        let existingRecord = try await Swipe.query(on: req.db) //see if any record exists where current prospect has swiped on current swiper
                .filter(\.$swiperId == lowerPId)
                .filter(\.$prospectId == lowerSId)
                .first()
        do {
            if(existingRecord == nil){ //no record exists, create one
                let record = Swipe(swiperId: lowerSId, //force lowercase IDs for consistency
                                   prospectId: lowerPId,
                                   type: temp.type,
                                   createdAt: Date())
                try await record.create(on: req.db)
                return false //no match
            }
            
            let id = existingRecord?.id!
            let lowerId = UUID(String(id!).lowercased())!
            
            //a record did exist between the two users
            if(existingRecord?.type != 2 && temp.type != 2){
                //both users swiped yes (on thier own or through wing) create a match record and ?delete swipe record?
                let matchRecord: Match
                if(existingRecord?.type == 3 || temp.type == 3){
                    matchRecord = Match(firstUserId: lowerSId, secondUserId: lowerPId, type: 2) //via wing
                } else {
                    matchRecord = Match(firstUserId: lowerSId, secondUserId: lowerPId, type: 1) //direct
                }
                try await matchRecord.create(on: req.db)
                
                //TODO Remove this?
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
        
        return false
    }
    
    //unmatch given both user IDs
    app.post("unmatch",":id1",":id2"){ req async throws -> Response in
        //delete match record
        let id1 = UUID(req.parameters.get("id1")!.lowercased())
        let id2 = UUID(req.parameters.get("id2")!.lowercased())
        
        try await Match.query(on: req.db)
            .filter(\.$first_user_id == id1)
            .filter(\.$second_user_id == id2)
            .delete()
        
        try await Match.query(on: req.db)
            .filter(\.$first_user_id == id2)
            .filter(\.$second_user_id == id1)
            .delete()
        
        return Response(status: .accepted)
    }
    
    //get all prospects profileIDs
    
    
    
}
