//
//  Recipes.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/28/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI
import CoreData

struct Recipes : View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest()) var allRecipes: FetchedResults<Recipe>
    
    var body: some View {
        NavigationView {
            List {
            VStack {
                Spacer()
                // Group the two scroll views containing new recipes into one section
                Group {
                    HStack {
                        Text("New Recipes")
                            .font(.system(size: 42))
                            .fontWeight(.bold)
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: "star.circle")
                            .font(.system(size: 32))
                            .foregroundColor(.yellow)
                            .padding(.trailing, 15)
                    }
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            ForEach(userData.recipesList) { recipe in
                                
                                RecipeCard(recipe: recipe)
                                
                            }   // End of ForEach
                            
                        }   // End of HStack
                        .font(.system(size: 14))
                    }   // End of ScrollView
                
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            ForEach(userData.dessertsList) { recipe in
                                
                                RecipeCard(recipe: recipe)
                                
                            }   // End of ForEach
                        }   // End of HStack
                        .font(.system(size: 14))
                        
                    }   // End of ScrollView
                }
                Spacer()
                HStack {
                    Text("Favorites")
                        .font(.system(size: 42))
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                    Spacer()
                    Image(systemName: "heart.circle")
                        .font(.system(size: 32))
                        .foregroundColor(.pink)
                        .padding(.trailing, 15)
                    
                }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        ForEach(self.allRecipes) { recipe in
                            
                            // Once a user has decided that a recipe looks interesting and it has been added to the favorites, they can then view the full details, which is why we wrap the item with a navigation link to the favorite details view
                            NavigationLink(destination: FavoriteDetails(recipe: recipe)){
                                FavoriteCard(recipe: recipe)
                            }
                        }   // End of ForEach
                    }   // End of HStack
                    .font(.system(size: 14))
                    
                }   // End of ScrollView
            }   // End of VStack
            .navigationBarHidden(true)
        }
        }
    }   // End
}
