//
//  SpoonacularData.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/28/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import CoreData
import SwiftUI

var unsavedRecipes = [RecipeStruct]()
var unsavedDesserts = [RecipeStruct]()
let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let userDiet = getDietFromUserDefaults()

/*
 *********************************************
 MARK: - Obtain Recipes based on Diet
 *********************************************
 */
public func getRecipesData() {
    let apiKey = "702e7ebe105e4f29b6aeac6c86e39b3c"
    
   
    
    let recipeApiUrl = "https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=15&tags=\(userDiet),main+course"
    
    
    var recipes = [RecipeStruct]()
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: recipeApiUrl)
    
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            return
        }
        
        var rName = "", rCalories = 0, rInstructions = "", rIngredients = "", rPicture = "", rID = 0, rServings = 0, rTime = 0, rWebsite = "", rFat = 0, rProtein = 0, rCarbs = 0;
        
        var jsonDataArray = [Any]()
        if let jsonData = jsonDataDictionary["recipes"] as? [Any] {
            jsonDataArray = jsonData
        } else {
            return
        }
        
        var count = 0;
        for item in jsonDataArray {
            let recipeName = item as! [String: Any]
            if let recipeTitle = recipeName["title"] as? String {
                rName = recipeTitle
            }
            
            let recipePicture = item as! [String: Any]
            if let recipeImage = recipePicture["image"] as? String {
                rPicture = recipeImage
            }
            
            let recipeSize = item as! [String: Any]
            if let recipeServings = recipeSize["servings"] as? Int {
                rServings = recipeServings
            }
            
            let recipeID = item as! [String: Any]
            if let spoonID = recipeID["id"] as? Int {
                rID = spoonID
            }
            
            let recipeReady = item as! [String: Any]
            if let recipeTime = recipeReady["readyInMinutes"] as? Int {
                rTime = recipeTime
            }
            
            let recipeWebsite = item as! [String: Any]
            if let recipeUrl = recipeWebsite["spoonacularSourceUrl"] as? String {
                rWebsite = recipeUrl
            }
            
            let recipeProcedure = item as! [String: Any]
            if let recipeInstructions = recipeProcedure["instructions"] as? String {
                rInstructions = recipeInstructions
            }
            
            var jsonDataArray2 = [Any]()
            let ingredientsList = item as! [String: Any]
            if let jsonData2 = ingredientsList["extendedIngredients"] as? [Any] {
                jsonDataArray2 = jsonData2
            } else {
                return
            }
            
            var tempIngredients = ""
            for ingredient in jsonDataArray2 {
                let ingredientName = ingredient as! [String: Any]
                if let ingredientTitle = ingredientName["original"] as? String {
                    tempIngredients += ingredientTitle + ", "
                }
            }
            rIngredients = String(tempIngredients.dropLast(2))
            
            let recipeApiUrl2 = "https://api.spoonacular.com/recipes/\(rID)/nutritionWidget.json?apiKey=\(apiKey)"
            
            let jsonDataFromApi2 = getJsonDataFromApi(apiUrl: recipeApiUrl2)
            
            do {
                let jsonResponse2 = try JSONSerialization.jsonObject(with: jsonDataFromApi2!,
                                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
                
                var jsonDataDictionary2 = Dictionary<String, Any>()
                
                if let jsonObject3 = jsonResponse2 as? [String: Any] {
                    jsonDataDictionary2 = jsonObject3
                } else {
                    return
                }
                
                if let recipeFat = jsonDataDictionary2["fat"] as? String {
                    rFat = Int(recipeFat.dropLast()) ?? 0
                }
                
                if let recipeProtein = jsonDataDictionary2["protein"] as? String {
                    rProtein = Int(recipeProtein.dropLast()) ?? 0
                }
                
                if let recipeCalories = jsonDataDictionary2["calories"] as? String {
                    rCalories = Int(recipeCalories) ?? 0
                    
                }
                
                if let recipeCarbs = jsonDataDictionary2["carbs"] as? String {
                    rCarbs = Int(recipeCarbs.dropLast()) ?? 0
                }
                
                let aRecipe = RecipeStruct(carbs: rCarbs, calories: rCalories, fat: rFat, ingredients: rIngredients, instructions: rInstructions, name: rName, picture: rPicture, protein: rProtein, id: rID, servings: rServings, time: rTime, website: rWebsite)
                
                recipes.append(aRecipe)
            }
            catch{
                return
            }
            count += 1
        }
    }
    catch{
        return
    }
    
    unsavedRecipes = recipes
}

public func getDessertsData() {
    let apiKey = "702e7ebe105e4f29b6aeac6c86e39b3c"
    let recipeApiUrl = "https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=15&tags=\(userDiet),dessert"
    
    var recipes = [RecipeStruct]()
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: recipeApiUrl)
    
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            return
        }
        
        var rName = "", rCalories = 0, rInstructions = "", rIngredients = "", rPicture = "", rID = 0, rServings = 0, rTime = 0, rWebsite = "", rFat = 0, rProtein = 0, rCarbs = 0;
        
        var jsonDataArray = [Any]()
        if let jsonData = jsonDataDictionary["recipes"] as? [Any] {
            jsonDataArray = jsonData
        } else {
            return
        }
        
        var count = 0;
        for item in jsonDataArray {
            let recipeName = item as! [String: Any]
            if let recipeTitle = recipeName["title"] as? String {
                rName = recipeTitle
            }
            
            let recipePicture = item as! [String: Any]
            if let recipeImage = recipePicture["image"] as? String {
                rPicture = recipeImage
            }
            
            let recipeSize = item as! [String: Any]
            if let recipeServings = recipeSize["servings"] as? Int {
                rServings = recipeServings
            }
            
            let recipeID = item as! [String: Any]
            if let spoonID = recipeID["id"] as? Int {
                rID = spoonID
            }
            
            let recipeReady = item as! [String: Any]
            if let recipeTime = recipeReady["readyInMinutes"] as? Int {
                rTime = recipeTime
            }
            
            let recipeWebsite = item as! [String: Any]
            if let recipeUrl = recipeWebsite["spoonacularSourceUrl"] as? String {
                rWebsite = recipeUrl
            }
            
            let recipeProcedure = item as! [String: Any]
            if let recipeInstructions = recipeProcedure["instructions"] as? String {
                rInstructions = recipeInstructions
            }
            
            var jsonDataArray2 = [Any]()
            let ingredientsList = item as! [String: Any]
            if let jsonData2 = ingredientsList["extendedIngredients"] as? [Any] {
                jsonDataArray2 = jsonData2
            } else {
                return
            }
            
            var tempIngredients = ""
            for ingredient in jsonDataArray2 {
                let ingredientName = ingredient as! [String: Any]
                if let ingredientTitle = ingredientName["original"] as? String {
                    tempIngredients += ingredientTitle + ", "
                }
            }
            rIngredients = String(tempIngredients.dropLast(2))
            
            let recipeApiUrl2 = "https://api.spoonacular.com/recipes/\(rID)/nutritionWidget.json?apiKey=\(apiKey)"
            
            let jsonDataFromApi2 = getJsonDataFromApi(apiUrl: recipeApiUrl2)
            
            do {
                let jsonResponse2 = try JSONSerialization.jsonObject(with: jsonDataFromApi2!,
                                                                     options: JSONSerialization.ReadingOptions.mutableContainers)
                
                var jsonDataDictionary2 = Dictionary<String, Any>()
                
                if let jsonObject3 = jsonResponse2 as? [String: Any] {
                    jsonDataDictionary2 = jsonObject3
                } else {
                    return
                }
                
                if let recipeFat = jsonDataDictionary2["fat"] as? String {
                    rFat = Int(recipeFat.dropLast()) ?? 0
                }
                
                if let recipeProtein = jsonDataDictionary2["protein"] as? String {
                    rProtein = Int(recipeProtein.dropLast()) ?? 0
                }
                
                if let recipeCalories = jsonDataDictionary2["calories"] as? String {
                    rCalories = Int(recipeCalories) ?? 0
                    
                }
                
                if let recipeCarbs = jsonDataDictionary2["carbs"] as? String {
                    rCarbs = Int(recipeCarbs.dropLast()) ?? 0
                }
                
                let aRecipe = RecipeStruct(carbs: rCarbs, calories: rCalories, fat: rFat, ingredients: rIngredients, instructions: rInstructions, name: rName, picture: rPicture, protein: rProtein, id: rID, servings: rServings, time: rTime, website: rWebsite)
                
                recipes.append(aRecipe)
            }
            catch{
                return
            }
            count += 1
        }
    }
    catch{
        return
    }
    
    unsavedDesserts = recipes
}
