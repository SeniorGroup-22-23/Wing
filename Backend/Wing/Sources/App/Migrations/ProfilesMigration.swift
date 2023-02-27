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
            .field("user_id", .uuid, .required)
            .field("name", .string)
            .field("birthdate", .datetime)
            .field("occupation", .string)
            .field("bio", .string)
            .field("gender", .int16)
            .field("preference", .int16)
            .field("min_age", .int16)
            .field("max_age", .int16)
            .field("max_distance", .int16)
            .field("curr_latitude", .double)
            .field("curr_longitude", .double)
        
            .foreignKey("user_id", references: "users", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profiles").delete()
    }
}
