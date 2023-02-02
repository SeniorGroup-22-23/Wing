//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Fluent
import Models

struct CreateWings: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("wings")
            .id()
            .field("sender_id", .uuid, .required)
            .field("recipient_id", .uuid, .required)
            .field("prospect_id", .uuid, .required)
            .field("status", .int16, .required)
        
            .foreignKey("sender_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("recipient_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("prospect_id", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("wings").delete()
    }
}
