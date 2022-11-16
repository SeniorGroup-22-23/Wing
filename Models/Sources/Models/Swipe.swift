//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Fluent
import Vapor

public final class Swipe: Model, Content{
    
    public static let schema = "swipes"
    
    @ID(key: .id)
    public var id: UUID?
    
    // user id referencing user that swiped on a profile
    @Field(key: "swiper_id")
    public var swiperId: UUID
    
    //user id referencing user that was viewed and acted on by swiper
    @Field(key: "prospect_id")
    public var prospectId: UUID
    
    // 1 = like
    // 2 = dislike
    // 3 = like from wing
    @Field(key: "type")
    public var type: Int16 //would we rather have integer codes?
    
    //datetime when swipe occured, used to clear old records
    @Timestamp(key: "created_at", on: .create)
    public var createdAt: Date? // TBD
    
    public init(){
        
    }
    
    public init(id: UUID? = nil, swiperId: UUID, prospectId: UUID, type: Int16, createdAt: Date? = nil){
        self.id = id
        self.swiperId = swiperId
        self.prospectId = prospectId
        self.type = type
        self.createdAt = createdAt //probably will change to get date/time of initialization
    }
    
}
