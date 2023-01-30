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
            .foreignKey("first_user_id", references: "users", "id")
            .foreignKey("second_user_id", references: "users", "id")
            //.field("first_user_id", .uuid, .required, .references("users", "id"))
            //.field("second_user_id", .uuid, .required, .references("users", "id"))
            .field("type", .int16, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("matches").delete()
    }
}
