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
            .field("sender", .uuid, .required, .references("users", "id"))
            .field("recipient", .uuid, .required, .references("users", "id"))
            .field("prospect", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("wings").delete()
    }
}
