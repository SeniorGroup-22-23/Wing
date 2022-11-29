//
//  File.swift
//  
//
//  Created by Allie Griffin on 2022-11-27.
//

import FluentPostgresDriver
import Vapor
import Models

//Wing Block Routes 
func blockRoutes(_ app: Application) throws {
    
    //POST Block
    app.post("block"){ req async throws -> Block in
        let block = try req.content.decode(Block.self)
        do {
            try await block.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("blocks_blocked_user_id_fkey")){
                throw Error.notFoundwID("user", block.blockedUserId)
            } else if (error.localizedDescription.contains("blocks_blocked_by_id_fkey")){
                throw Error.notFoundwID("user", block.blockedById)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create block: \(error)")
            }
        }
        return block
    }
    
    //PUT Block (update block record)
    app.put("block"){ req async throws -> Block in
        let block = try req.content.decode(Block.self)
        try await Block.query(on: req.db)
            .set(\.$reported, to : block.reported)
            .filter(\.$id == block.id!)
            .update()
        return block
    }
    
    //GET Block Records by blockedById
    app.get("block", ":blockedById") { req async throws -> [Block] in
        guard let blockedById = UUID(uuidString: req.parameters.get("blockedById")!)
        else {
             throw Error.nilId
        }
        let blocks = try await Block.query(on: req.db)
            .filter(\.$blockedById == blockedById)
            .all()
        return blocks
    }
    
    
}
