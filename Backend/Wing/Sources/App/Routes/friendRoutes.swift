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
        try await friendship.create(on: req.db)
        return friendship
    }
    
    
    app.put("friend"){ req async throws -> Friendship in
        let friendship = try req.content.decode(Friendship.self)
        guard friendship.id != nil else {
            throw Error.nilId
        }
        try await Friendship.query(on: req.db)
            .set(\.$status, to : friendship.status) //update status of friendship (pending, approved)
            .filter(\.$id == friendship.id!)
            .update()
        return friendship
    }
    
    app.get("friends", ":userId"){ req async throws -> [UUID] in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!)
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
        
        //query to find all friend profiles for UUID?
            
        return friends1 + friends2
    }
    
    
    app.get("friendRequests", ":userId"){ req async throws -> [Friendship] in
        guard let userId = UUID(uuidString: req.parameters.get("userId")!)
        else {
             throw Error.nilId
        }
        let requests = try await Friendship.query(on: req.db)
            .filter(\.$respondentId == userId)
            .filter(\.$status == 1)
            .all()
        
        //query to find all friend profiles that match UUID requesterId
        //return array [[friendship, friendProfile], [friendship, friendProfile], ....]
            
        return requests //need to return whole struct to allow for updates (need friendship Id)
    }
    
    
    app.get("friend", ":username"){ req async throws -> UUID in
        let usernameMatch = req.parameters.get("username")! //! forces decode to string, if empty no error
        let users = try await User.query(on: req.db) //instead I would like to query friendProfile here
            .filter(\.$username == usernameMatch)
            .all(\.$id) //returns username field from all matches
        if(users.isEmpty){
            throw Error.userNotFound
        }
        return users[0] //instead return friendProfile (better for display)
    }
    
    
}
