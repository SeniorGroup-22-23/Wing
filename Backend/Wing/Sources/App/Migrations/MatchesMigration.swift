//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Fluent
import Models

struct CreateMatches: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("matches")
            .id()
            .field("first_user", .uuid, .required, .references("users", "id"))
            .field("second_user", .uuid, .required, .references("users", "id"))
            .field("type", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("matches").delete()
    }
}
