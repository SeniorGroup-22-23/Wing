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
            .field("user_id", .uuid, .required)
            .field("username", .string)
            .field("name", .string)
            .field("primary_photo", .data)
        
            .foreignKey("user_id", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profile_previews").delete()
    }
}
