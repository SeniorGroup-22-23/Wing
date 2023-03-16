//
//  friendRoutes.swift
//  
//
//  Created by Allie Griffin on 2022-12-08.
//

import FluentPostgresDriver
import Vapor
import Models

extension UUID: Content{}

func friendRoutes(_ app: Application) throws {
    
    app.post("friend"){ req async throws -> Friendship in
        let friendship = try req.content.decode(Friendship.self)
        do {
            try await friendship.create(on: req.db)
        } catch {
            if(error.localizedDescription.contains("friendships_requester_id_fkey")){
                throw Error.notFoundwID("user", friendship.requesterId)
            } else if(error.localizedDescription.contains("friendships_respondent_id_fkey")){
                throw Error.notFoundwID("user", friendship.respondentId)
            } else {
                throw Abort(.internalServerError, reason: "Unable to create friendship: \(error)")
            }
        }
        return friendship
    }
    
    
    app.put("friend"){ req async throws -> Friendship in
        let friendship = try req.content.decode(Friendship.self)
        guard friendship.id != nil else {
            throw Error.nilId
        }
        if friendship.status == 3 { //friend request declined, delete friend record
            try await Friendship.query(on: req.db)
                .filter(\.$id == UUID(friendship.id!.uuidString.lowercased())!)
                .delete()
        } else {
            try await Friendship.query(on: req.db)
                .set(\.$status, to : friendship.status) //update status of friendship (pending, approved)
                .filter(\.$id == UUID(friendship.id!.uuidString.lowercased())!)
                .update()
        }
        return friendship
    }
    
    app.get("friends", ":userId"){ req async throws -> [UUID] in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        
        let friends1 = try await Friendship.query(on: req.db) //get any friends where userId was respondent & accepted
            .filter(\.$respondentId == userId)
            .filter(\.$status == 2)
            .all(\.$requesterId)
        
        let friends2 = try await Friendship.query(on: req.db) //get any friends where userId was requester & respondent accepted
            .filter(\.$requesterId == userId)
            .filter(\.$status == 2)
            .all(\.$respondentId)
        
        let friends = friends1 + friends2
        var profilePreviews = [UUID]()
        
        if(!friends.isEmpty){
            profilePreviews = try await ProfilePreview.query(on: req.db)
                .filter(\.$userId ~~ friends) //userId in friends
                .all(\.$id)
        }
            
        return profilePreviews
    }
    
    //Get Friendships (returns array of friendship structs)
    app.get("friendships", ":userId"){ req async throws -> [Friendship] in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        
        let friends1 = try await Friendship.query(on: req.db) //get any friends where userId was respondent & accepted
            .filter(\.$respondentId == userId)
            .filter(\.$status == 2)
            .all()
        
        let friends2 = try await Friendship.query(on: req.db) //get any friends where userId was requester & respondent accepted
            .filter(\.$requesterId == userId)
            .filter(\.$status == 2)
            .all()
        
        return friends1 + friends2
    }
    
    app.get("friendRequests", ":userId"){ req async throws -> [Friendship] in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!.lowercased())
        else {
             throw Error.nilId
        }
        let requests = try await Friendship.query(on: req.db)
            .filter(\.$respondentId == userId)
            .filter(\.$status == 1)
            .all()
            
        return requests //need to return whole struct to allow for updates (need friendship Id)
    }
}
