//
//  profilePreviewRoutes.swift
//  
//
//  Created by Allie Griffin on 2022-12-21.
//

import FluentPostgresDriver
import Vapor
import Models


func profilePreviewRoutes(_ app: Application) throws {
    
    app.post("profilePreview"){ req async throws -> ProfilePreview in
        let preview = try req.content.decode(ProfilePreview.self)
        try await preview.create(on: req.db)
        return preview
    }
    
    app.put("profilePreview"){ req async throws -> ProfilePreview in
        let preview = try req.content.decode(ProfilePreview.self)
        guard preview.id != nil else {
            throw Error.nilId
        }
    
        try await ProfilePreview.query(on: req.db)
            .set(\.$name, to : preview.name) //update name and primary photo only (username & id are static)
            .set(\.$primaryPhoto, to : preview.primaryPhoto)
            .filter(\.$id == UUID(preview.id!.uuidString.lowercased())!)
            .update()

        return preview
    }
    
    
    //THIS IS A TEMP ROUTE FOR TESTING BYTEA IN POSTGRES
    // ****** TO BE DELETED *************
    
    app.get("profilePreview", ":username") {req async throws -> ProfilePreview in
        let username = req.parameters.get("username")!
        guard let preview = try await ProfilePreview.query(on: req.db)
            .filter(\.$username == username)
            .first() //Will throw error if no User is found
        else {
            throw Error.profileNotFound
        }
        return preview
    }
    
    //******** END OF SECTION TO DELETE *********
    
}
