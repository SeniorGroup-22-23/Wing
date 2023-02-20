//
//  File.swift
//  
//
//  Created by Allie Griffin on 2022-11-27.
//

import FluentPostgresDriver
import Vapor
import Models
import JWT

//Wing Block Routes 
func blockRoutes(_ app: Application) throws {
    
    //POST Block
    app.post("block"){ req async throws -> Block in
        try req.jwt.verify(as: WingJWTPayload .self)
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
        try req.jwt.verify(as: WingJWTPayload .self)
        let block = try req.content.decode(Block.self)
        try await Block.query(on: req.db)
            .set(\.$reported, to : block.reported)
            .filter(\.$id == UUID(block.id!.uuidString.lowercased())!)
            .update()
        return block
    }
    
    //GET Block Records by blockedById
    app.get("block", ":blockedById") { req async throws -> [Block] in
        try req.jwt.verify(as: WingJWTPayload .self)
        guard let blockedById = UUID(uuidString: req.parameters.get("blockedById")!.lowercased())
        else {
             throw Error.nilId
        }
        let blocks = try await Block.query(on: req.db)
            .filter(\.$blockedById == blockedById)
            .all()
        return blocks
    }
    
    
}
