//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Fluent
import Models

struct CreateBlocks: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("blocks")
        
            .id()
            .field("blocked_user_id", .uuid, .required)
            .field("blocked_by_user", .uuid, .required)
            .field("reported", .bool, .required)
            .field("issue", .int16)
            
            .foreignKey("blocked_user_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("blocked_by_user", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("blocks").delete()
    }
}

