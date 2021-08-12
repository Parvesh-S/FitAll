//
//  Foods.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct Foods: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Food.allFoodFetchRequest()) var allFoods: FetchedResults<Food>
    
    var body: some View {
        NavigationView {
            if allFoods.isEmpty {
                Text("Tap the "+" button to start adding food to your log!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .navigationBarTitle(Text("My Food Log"), displayMode: .inline)
                    .navigationBarItems(leading: EditButton(), trailing:
                                            NavigationLink(destination: AddFood()) {
                                                Image(systemName: "plus")
                                            })
            }
            else {
                List {
                    /*
                     Each NSManagedObject has internally assigned unique ObjectIdentifier
                     used by ForEach to display the Trips in a dynamic scrollable list.
                     */
                    ForEach(self.allFoods) { aFood in
                        FoodItem(food: aFood)
                    }
                    .onDelete(perform: delete)
                }   // End of List
                .navigationBarTitle(Text("My Food Log"), displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing:
                                        NavigationLink(destination: AddFood()) {
                                            Image(systemName: "plus")
                                        })
            }
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func delete(at offsets: IndexSet) {
        let foodToDelete = self.allFoods[offsets.first!]
        
        self.managedObjectContext.delete(foodToDelete)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Unable to delete selected trip!")
        }
    }
}
