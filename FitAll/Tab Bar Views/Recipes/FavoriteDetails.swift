//
//  FavoriteDetails.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct FavoriteDetails: View {

    let recipe: Recipe
    
    // Each section contains the attributes for the recipe, including a link to the website with the full recipe breakdown
    var body: some View {
        Form {
            Section(header: Text("Recipe Title")) {
                Text(recipe.name ?? "")
            }
            Section(header: Text("Recipe Photo")) {
                getImageFromUrl(url: recipe.picture!, defaultFilename: "DefaultTripPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Recipe Calories & Servings")) {
                Text("\(recipe.calories!) kCal, \(recipe.servings!) servings")
            }
            Section(header: Text("Recipe Time")) {
                Text("\(recipe.time!) min")
            }
            Section(header: Text("Basic Nutrition")) {
                Text("Protein: \(recipe.protein!) g")
                Text("Carbs: \(recipe.carbs!) g")
                Text("Fat: \(recipe.fat!) g")
            }
            Section(header: Text("Recipe Ingredients")) {
                Text(recipe.ingredients!)
            }
            Section(header: Text("Recipe Instructions")) {
                Text(recipe.instructions!)
            }
            Section(header: Text("Full Recipe Breakdown")) {
                NavigationLink(destination:
                                WebView(url: recipe.website!)
                                .navigationBarTitle(Text(recipe.name!), displayMode: .inline)
                ){
                    HStack {
                        Image(systemName: "leaf")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.green)
                        Text("Show Full Recipe Breakdown")
                            .font(.system(size: 16))
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                }
            }
        }
        .font(.system(size: 14))
        .navigationBarTitle(Text("\(recipe.name!)"), displayMode: .inline)
        
    }   // End of body
}

