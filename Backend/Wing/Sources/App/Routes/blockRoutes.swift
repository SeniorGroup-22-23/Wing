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
    
    //POST Block -- should we check if the user IDs exist? 
    app.post("block"){ req async throws -> Block in
        let block = try req.content.decode(Block.self)
        try await block.create(on: req.db)
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
