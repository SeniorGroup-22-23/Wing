//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-11-11.
//

import Fluent
import Models

struct CreatePhotos: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("photos")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("photo", .array(of: .uint), .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("photos").delete()
    }
}
