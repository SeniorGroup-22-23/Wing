//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Fluent
import Models

struct CreateMessages: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("messages")
            .id()
            .field("sender", .uuid, .required, .references("users", "id"))
            .field("recipient", .uuid, .required, .references("users", "id"))
            .field("content", .string, .required)
            .field("status", .int, .required)
            .field("sent_at", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("messages").delete()
    }
}
