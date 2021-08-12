//
//  RecipeCard.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/28/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: RecipeStruct
    @EnvironmentObject var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var offset = 0
    
    var body: some View {
        HStack{
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                // The recipe's image is put within a ZStack with .bottom specified. This allows the recipe's image to be the the background of the card.
                getImageFromUrl(url: recipe.picture, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 3.6))
                    .cornerRadius(15)
                    .opacity(0.6)
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content:
                        {
                            // Everything within this ZStack is tagged with the .top argument. This means the text and buttons will sit atop the image and be clearly visible to the user.
                            VStack(alignment: .leading,spacing: 18){
                                HStack{
                                    Text(recipe.name)
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Button(action: { delete(recipe: recipe) }, label: {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                            .padding(.all,10)
                                            .background(Color.red)
                                            .clipShape(Circle())
                                    })
                                    
                                    Button(action: { save(recipe: recipe) }, label: {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                            .padding(.all,10)
                                            .background(Color.green)
                                            .clipShape(Circle())
                                    })
                                    
                                    
                                }
                            }
                            .frame(width: calculateWidth() - 40)
                            .padding(.leading,20)
                            .padding(.bottom,20)
                        })
            }
            
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .padding(.leading, 10)
        .offset(y: CGFloat(self.offset))
    }
    
    // Calculates the with of each card, based on the dimensions of the phone's screen. This ensures each card is the same size and scalable to iOS devices of different sizes.
    func calculateWidth()->CGFloat{
        
        let screen = UIScreen.main.bounds.width - 25
        
        let width = screen - (2 * 60)
        
        return width
    }
    
    // Delete recipe from our array of recipes that we obtained from the API on App load
    func delete(recipe: RecipeStruct) {
        withAnimation(Animation.easeIn(duration: 0.8)){
            self.offset = -500
          }
        if let index = userData.recipesList.firstIndex(of: recipe) {
            userData.recipesList.remove(at: index)
            unsavedRecipes = userData.recipesList
        }
        else if let index2 = userData.dessertsList.firstIndex(of: recipe) {
            userData.dessertsList.remove(at: index2)
            unsavedDesserts = userData.dessertsList
        }
    }
    
    // First save the recipe to our Core DB so that the user can reference it later, then delete it from the original array. It will now exist in the Favorites section, so we don't need it in the new recipes section. 
    func save(recipe: RecipeStruct) {
        withAnimation(Animation.easeIn(duration: 0.8)){
            self.offset = 1500
          }
        
        let sRecipe = Recipe(context: managedObjectContext)
        
        sRecipe.calories = NSNumber(value: recipe.calories)
        sRecipe.carbs = NSNumber(value: recipe.carbs)
        sRecipe.fat = NSNumber(value: recipe.fat)
        sRecipe.id = NSNumber(value: recipe.id)
        sRecipe.ingredients = recipe.ingredients
        sRecipe.instructions = recipe.instructions
        sRecipe.name = recipe.name
        sRecipe.picture = recipe.picture
        sRecipe.protein = NSNumber(value: recipe.protein)
        sRecipe.servings = NSNumber(value: recipe.servings)
        sRecipe.website = recipe.website
        sRecipe.time = NSNumber(value: recipe.time)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("was not able to save")
            return
        }
        
        delete(recipe: recipe)
    }
}

