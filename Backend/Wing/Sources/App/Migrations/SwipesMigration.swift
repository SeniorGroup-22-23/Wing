//
//  SwipesMigration.swift
//  
//
//  Created by Courtney Perreault on 2022-11-03.
//

import Fluent
import Models

struct CreateSwipes: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("swipes")
            .id()
            .field("swiper_id", .uuid, .required)
            .field("prospect_id", .uuid, .required)
            .field("type", .int16)
            .field("created_at", .datetime)
        
            .foreignKey("swiper_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("prospect_id", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("swipes").delete()
    }
}

