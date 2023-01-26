//
//  wingRoutes.swift
//  
//
//  Created by Allie Griffin on 2023-01-10.
//

import FluentPostgresDriver
import Vapor
import Models


func wingRoutes(_ app: Application) throws {
    
    app.post("hello"){ req in
        return "Hello! This test worked."
    }
    
    app.post("wing"){ req async throws -> Wing in
        let wing = try req.content.decode(Wing.self)
        wing.prospectId = UUID(String(wing.prospectId).lowercased())!
        wing.senderId = UUID(String(wing.senderId).lowercased())!
        wing.recipientId = UUID(String(wing.recipientId).lowercased())!
        do {
            try await wing.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("wings_sender_id_fkey")){
                throw Error.notFoundwID("user", wing.senderId)
            } else if(error.localizedDescription.contains("wings_recipient_id_fkey")){
                throw Error.notFoundwID("user", wing.recipientId)
            } else if(error.localizedDescription.contains("wings_prospect_id_fkey")){
                throw Error.notFoundwID("user", wing.prospectId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create wing: \(error)")
            }
        }
        return wing
    }
    
    
    app.get("wings", ":userId"){ req async throws -> [Wing] in
        guard let userId = UUID(req.parameters.get("userId")!.lowercased())
        else {
            throw Error.nilId
        }
        let wings = try await Wing.query(on: req.db)
            .filter(\.$recipientId == userId)
            .filter(\.$status == 1) //pending
            .all()
            
        return wings //need to return whole struct to allow for updates to each record 
    }
    
    //Use when recipient accepts or declines wing 
    //Returns true if match is made, false otherwise
    app.put("wing"){ req async throws -> Bool in
        let wing = try req.content.decode(Wing.self)
        let lowerRId = UUID(String(wing.recipientId).lowercased())!
        let lowerPId = UUID(String(wing.prospectId).lowercased())!
        let wingId = UUID(String(wing.id!).lowercased())!
        
        let existingSwipeRecord = try await Swipe.query(on: req.db) //see if any record exists where current prospect has swiped on reciepient
                .filter(\.$swiperId == lowerPId)
                .filter(\.$prospectId == lowerRId)
                .first()

        do{
            if(existingSwipeRecord == nil){ //no record exists, create one
                if(wing.status == 2){
                    let record = Swipe(swiperId: lowerRId,
                                       prospectId: lowerPId,
                                       type: 3, //liked from wing
                                       createdAt: Date())
                    try await record.create(on: req.db)
                    try await Wing.query(on: req.db) //update wing record
                        .filter(\.$id == wingId)
                        .set(\.$status, to: 2)
                        .update()
                    return false
                } else {
                    let record = Swipe(swiperId: lowerRId,
                                       prospectId: lowerPId,
                                       type: 2, //dislike
                                       createdAt: Date())
                    try await record.create(on: req.db)
                    try await Wing.query(on: req.db) //delete wing record if dislike
                        .filter(\.$id == wingId)
                        .delete()
                    return false
                }
            } else { //there is an existing record
                let id = existingSwipeRecord?.id!
                let lowerId = UUID(String(id!).lowercased())!
                
                if(wing.status == 2 && existingSwipeRecord!.type != 2){
                    let matchRecord = Match(firstUserId: lowerRId, secondUserId: lowerPId, type: 2) //via wing
                    try await matchRecord.create(on: req.db)
                    try await Swipe.query(on: req.db)
                        .filter(\.$id == lowerId)
                        .delete()
                    try await Wing.query(on: req.db) //update wing record
                        .filter(\.$id == wingId)
                        .set(\.$status, to: 2)
                        .update()
                    return true
                    
                } else {
                    try await Swipe.query(on: req.db) //update swipe to dislike
                        .set(\.$type, to: 2)
                        .filter(\.$id == lowerId)
                        .update()
                    try await Wing.query(on: req.db) //delete wing record
                        .filter(\.$id == wingId)
                        .delete()
                    return false
                }
            }
        } catch {
            if(error.localizedDescription.contains("swipes_swiper_id_fkey")){
                throw Error.notFoundwID("user", lowerRId)
            } else if(error.localizedDescription.contains("swipes_prospect_id_fkey")){
                throw Error.notFoundwID("user", lowerPId)
            } else if(error.localizedDescription.contains("matches_first_user_id_fkey")){
                throw Error.notFoundwID("user", lowerRId)
            } else if(error.localizedDescription.contains("matches_second_user_id_fkey")){
                throw Error.notFoundwID("user", lowerPId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to update wing: \(error)")
            }
        }
    }
    
    
}
