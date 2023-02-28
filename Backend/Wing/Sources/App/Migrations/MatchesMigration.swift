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
            .field("first_user_id", .uuid, .required)
            .field("second_user_id", .uuid, .required)
            .field("type", .int16, .required)
        
            .foreignKey("first_user_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("second_user_id", references: "users", "id", onDelete: .cascade)
        
            .create()
            
    }

    func revert(on database: Database) async throws {
        try await database.schema("matches").delete()
    }
}
