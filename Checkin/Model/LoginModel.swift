//
//  LoginModel.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import Foundation
import SwiftUI

struct LoginResponse: Codable
{
    var status: String
    var message: String?
    var token: String?
    var data: Personal?
}

struct Personal: Codable
{
    var id: String
    var sku: String
    var phone: String
    var name: String
    var event_detail: EventDetailModel
}
