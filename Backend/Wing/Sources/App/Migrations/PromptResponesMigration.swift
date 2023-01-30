//
//  PromptResponsesMigration.swift
//  
//
//  Created by Courtney Perreault on 2022-10-30.
//

import Fluent
import Models

struct CreatePromptResponses: AsyncMigration {
    
    
    func prepare(on database: Database) async throws {
        try await database.schema("prompt_responses")
            .id()
            .field("user_id", .uuid, .required)
            .field("prompt_id", .uuid, .required)
            .field("response_text", .string, .required)
        
            .foreignKey("user_id", references: "users", "id", onDelete: .cascade)
            .foreignKey("prompt_id", references: "prompts", "id", onDelete: .cascade)
        
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("prompt_responses").delete()
    }
}
