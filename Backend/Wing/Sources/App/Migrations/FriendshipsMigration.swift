//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-03.
//

import Fluent
import Models

struct CreateFriendships: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("friendships")
            .id()
            .field("requester_id", .uuid, .required, .references("users", "id"))
            .field("respondent_id", .uuid, .required, .references("users", "id"))
            .field("status", .int)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("friendships").delete()
    }
}

