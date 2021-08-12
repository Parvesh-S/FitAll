//
//  RecipeStruct.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI
 
struct RecipeStruct: Hashable, Codable, Identifiable {
    var carbs: Int
    var calories: Int
    var fat: Int
    var ingredients: String
    var instructions: String
    var name: String
    var picture: String
    var protein: Int
    var id: Int
    var servings: Int
    var time: Int
    var website: String
}
