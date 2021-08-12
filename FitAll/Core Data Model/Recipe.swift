//
//  Recipe.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/28/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import CoreData

public class Recipe: NSManagedObject, Identifiable {
    @NSManaged public var carbs: NSNumber?
    @NSManaged public var calories: NSNumber?
    @NSManaged public var fat: NSNumber?
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?
    @NSManaged public var picture: String?
    @NSManaged public var protein: NSNumber?
    @NSManaged public var id: NSNumber?
    @NSManaged public var servings: NSNumber?
    @NSManaged public var time: NSNumber?
    @NSManaged public var website: String?
}

extension Recipe {
    static func allRecipesFetchRequest() -> NSFetchRequest<Recipe> {
       
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        /*
         List the recipes in alphabetical order with respect to recipe category;
         If recipe category is the same, then sort with respect to recipe name.
         */
        request.sortDescriptors = [
            // Primary sort key: trip rating
            NSSortDescriptor(key: "name", ascending: true),
            NSSortDescriptor(key: "calories", ascending: true)
        ]
       
        return request
    }
}
