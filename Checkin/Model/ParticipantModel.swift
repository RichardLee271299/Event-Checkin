//
//  Paticipant.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation

struct ParticipantResponse: Codable
{
    var status: String
    var message: String?
    var data: ParticipantData?
}
struct ParticipantData: Codable
{
    var id: String
    var name: String
    var sku: String
    var level: String
    var event_detail: EventDetailModel
}
struct EventDetailModel:Codable
{
    var id: String
    var date: String
    var time: String
    var name: String
}


//
// 
//
struct GetLevelsResponse: Codable
{
    var status: String
    var message: String?
    var list: [ID_Name_Model]?
}
