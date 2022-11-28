import FluentPostgresDriver
import Vapor
import Models

//Wing Routes
func propmtRoutes(_ app: Application) throws {
    
    //GET Prompts
    app.get("prompts") { req async throws in
        try await Prompt.query(on: req.db).all()
    }
    
    //GET Prompt by Prompt ID
    app.get("prompt", ":promptId") { req async throws -> Prompt in
        let promptId = UUID(uuidString: req.parameters.get("promptId")!)!
        guard let prompt = try await Prompt.query(on: req.db)
            .filter(\.$id == promptId)
            .first()
        else {
            throw Error.promptNotFound
        }
        
        return prompt
    }
    
    //GET Prompts by UserID (all prompt responses by user ID)
    app.get("prompts", ":userId") { req async throws -> [PromptResponse] in
        let userId = UUID(uuidString: req.parameters.get("userId")!)!
        let prompts = try await PromptResponse.query(on: req.db)
            .filter(\.$userId == userId)
            .all()
        return prompts
    }
    
    //POST Prompt Response to user account
    app.post("prompts", "user"){ req async throws -> PromptResponse in
        let promptResponse = try req.content.decode(PromptResponse.self)
        try await promptResponse.create(on: req.db)
        return promptResponse
    }
    
    //POST Prompt - Internal only!
    app.post("prompts") { req async throws in
        let prompt = try req.content.decode(Prompt.self)
        try await prompt.create(on: req.db)
        return prompt
    }
    
    //PUT Prompt Response (edit text response)
    app.put("promptResponse"){ req async throws -> PromptResponse in
        let promptRes = try req.content.decode(PromptResponse.self)
        guard promptRes.id != nil else {
            throw Error.nilId
        }
        try await PromptResponse.query(on: req.db)
            .set(\.$responseText, to : promptRes.responseText)
            .update()
        return promptRes
    }
    
    
    //DELETE Prompt Response (remove prompt from user)
    app.delete("promptResponse", ":id"){ req async throws -> Response in
       guard let id = UUID(uuidString: req.parameters.get("id")!)
        else {
           return Response(status: .badRequest)
       }
        try await PromptResponse.query(on: req.db)
            .filter(\.$id == id)
            .delete()
        return Response(status: .accepted)
    }

}

