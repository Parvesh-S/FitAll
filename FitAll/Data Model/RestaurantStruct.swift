//
//  RestaurantStruct.swift
//  FitAll
//
//  Created by keerthana on 11/27/20.
//

import SwiftUI

struct Restaurant: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var phone: String
    var address: String
    var website: String
    var latitude: Double
    var longitude: Double
    var locality: String
    var imageid: String
}
