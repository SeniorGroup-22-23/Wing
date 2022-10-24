//
//  File.swift
//  
//
//  Created by Courtney Perreault on 2022-10-24.
//

import Fluent
import Vapor

final class Swipe: Model, Content{
    
    static let schema = "swipes"
    
    @ID(key: .id)
    var id: UUID?
    
    // user id referencing user that swiped on a profile
    @Field(key: "swiper_id")
    var swiperId: UUID
    
    //user id referencing user that was viewed and acted on by swiper
    @Field(key: "prospect_id")
    var prospectId: UUID
    
    //indicates yes, no, or result of a wing
    @Field(key: "type")
    var type: String //would we rather have integer codes?
    
    //datetime when swipe occured, used to clear old records
    @Field(key: "created_at")
    var createdAt: Date // TBD
    
    init(){
        
    }
    
    init(id: UUID? = nil, swiperId: UUID, prospectId: UUID, type: String, createdAt: Date){
        self.id = id
        self.swiperId = swiperId
        self.prospectId = prospectId
        self.type = type
        self.createdAt = createdAt //probably will change to get date/time of initialization
    }
    
}
