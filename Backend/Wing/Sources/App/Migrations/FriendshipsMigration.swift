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
            .field("requester_id", .uuid, .required)
            .field("respondent_id", .uuid, .required)
            .field("status", .int16, .required)
        
            .foreignKey("requester_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("respondent_id", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("friendships").delete()
    }
}

