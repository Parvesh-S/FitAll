//
//  Food.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import CoreData

public class Food: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var calories: NSNumber?
    @NSManaged public var category: String?
}


extension Food {
    static func allFoodFetchRequest() -> NSFetchRequest<Food> {
       
        let request: NSFetchRequest<Food> = Food.fetchRequest() as! NSFetchRequest<Food>
        /*
         List the recipes in alphabetical order with respect to recipe category;
         If recipe category is the same, then sort with respect to recipe name.
         */
        request.sortDescriptors = [
            // Primary sort key: trip rating
            NSSortDescriptor(key: "calories", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
       
        return request
    }
}
