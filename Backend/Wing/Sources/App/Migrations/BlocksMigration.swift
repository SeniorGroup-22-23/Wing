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
            .foreignKey("blocked_user_id", references: "users", "id")
            .foreignKey("blocked_by_user", references: "users", "id")
            //.field("blocked_user_id", .uuid, .required, .references("users", "id"))
            //.field("blocked_by_id", .uuid, .required, .references("users", "id"))
            .field("reported", .bool, .required)
            .field("issue", .int16)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("blocks").delete()
    }
}

