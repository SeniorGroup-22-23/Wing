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
    
    //Returns true if match is made, false otherwise
    app.put("wing"){ req async throws -> Bool in
        let wing = try req.content.decode(Wing.self)
        let lowerRId = UUID(String(wing.recipientId).lowercased())!
        let lowerPId = UUID(String(wing.prospectId).lowercased())!
        let wingId = UUID(String(wing.id!).lowercased())!
        

        return false 
    }
    
    
}
