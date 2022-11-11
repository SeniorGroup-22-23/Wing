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
            .field("blocked_user", .uuid, .required, .references("users", "id"))
            .field("blocked_by", .uuid, .required, .references("users", "id"))
            .field("reported", .bool, .required)
            .field("issue", .int)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("blocks").delete()
    }
}

