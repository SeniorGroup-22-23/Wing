//
//  ProfilePreviewsModels.swift
//  
//
//  Created by Courtney Perreault on 2022-12-16.
//

import Fluent
import Models

struct CreateProfilePreviews: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("profile_previews")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("username", .string)
            .field("name", .string)
            .field("primary_photo", .data)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profile_previews").delete()
    }
}
