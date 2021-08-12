//
//  VideoStruct.swift
//  FitAll
//
//  Created by keerthana on 11/27/20.
//

import SwiftUI

struct Video: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var youtubeID: String
    var date: String
}

