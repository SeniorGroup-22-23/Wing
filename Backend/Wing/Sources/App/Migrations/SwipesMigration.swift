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
            .field("swiper", .uuid, .required, .references("users", "id"))
            .field("prospect", .uuid, .required, .references("users", "id"))
            .field("type", .int)
            .field("createed_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("swipes").delete()
    }
}

