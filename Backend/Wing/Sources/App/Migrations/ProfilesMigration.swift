//
//  ProfilesMigration.swift
//  
//
//  Created by Courtney Perreault on 2022-11-03.
//

import Fluent
import Models

struct CreateProfiles: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("profiles")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("name", .string)
            .field("birthdate", .datetime)
            .field("occupation", .string)
            .field("bio", .string)
            .field("gender", .int8)
            .field("preference", .int8)
            .field("min_age", .int8)
            .field("max_age", .int8)
            .field("max_distance", .int8)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profiles").delete()
    }
}
