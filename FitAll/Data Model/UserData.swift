//
//  UserData.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/30/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import Combine
import SwiftUI
import CoreData
 
final class UserData: ObservableObject {
    @Published var recipesList = unsavedRecipes
    @Published var dessertsList = unsavedDesserts
    @Published var name = UserDefaults.standard.string(forKey: "name")!
    @Published var diet = UserDefaults.standard.string(forKey: "diet")!
    @Published var dailyCalorieGoal = UserDefaults.standard.integer(forKey: "dailyCalorieGoal")
    @Published var caloriesBurnedGoal = UserDefaults.standard.integer(forKey: "dailyCaloriesBurnedGoal")
    @Published var weight = UserDefaults.standard.integer(forKey: "weight")
    @Published var goalWeight = UserDefaults.standard.integer(forKey: "goalWeight")
    @Published var caloriesConsumed = UserDefaults.standard.integer(forKey: "caloriesConsumed")
    @Published var waterConsumed = UserDefaults.standard.integer(forKey: "waterConsumed")
    @Published var caloriesBurned = UserDefaults.standard.integer(forKey: "caloriesBurned")
    
    func updateName(name: String) {
        UserDefaults.standard.set(String(name), forKey: "name")
        self.name = name
    }
    
    func updateDiet(diet: String) {
        UserDefaults.standard.set(diet, forKey: "diet")
        self.diet = diet
    }
    
    func updateCalorieGoal(goal: Int) {
        UserDefaults.standard.set(goal, forKey: "dailyCalorieGoal")
        self.dailyCalorieGoal = goal
    }
    
    func updateCalorieBurnGoal(goal: Int) {
        UserDefaults.standard.set(goal, forKey: "dailyCaloriesBurnedGoal")
        self.caloriesBurnedGoal = goal
    }
    
    func updateWeight(weight: Int) {
        UserDefaults.standard.set(weight, forKey: "weight")
        self.weight = weight
    }
    
    func updateWaterConsumed(water: Int) {
        UserDefaults.standard.set(water, forKey: "waterConsumed")
        self.waterConsumed = water
    }
    
    func updateCaloriesConsumed(calories: Int) {
        let existing = UserDefaults.standard.integer(forKey: "caloriesConsumed")
        UserDefaults.standard.set(existing + calories, forKey: "caloriesConsumed")
        self.caloriesConsumed = existing + calories
    }
    
    func updateCaloriesBurned(calories: Int) {
        let existing = UserDefaults.standard.integer(forKey: "caloriesBurned")
        UserDefaults.standard.set(existing + calories, forKey: "caloriesBurned")
        self.caloriesBurned = existing + calories
    }
    
    func updateGoalWeight(goal: Int) {
        UserDefaults.standard.set(goal, forKey: "goalWeight")
        self.goalWeight = goal
    }
    
    
}

func populateUserData(){
    UserDefaults.standard.set("John Doe", forKey: "name")
    UserDefaults.standard.set("Omnivore", forKey: "diet")
    UserDefaults.standard.set(2500, forKey: "dailyCalorieGoal")
    UserDefaults.standard.set(500, forKey: "dailyCaloriesBurnedGoal")
    UserDefaults.standard.set(160, forKey: "weight")
    UserDefaults.standard.set(0, forKey: "waterConsumed")
    UserDefaults.standard.set(0, forKey: "caloriesConsumed")
    UserDefaults.standard.set(0, forKey: "caloriesBurned")
    UserDefaults.standard.set(145, forKey: "goalWeight")
    UserDefaults.standard.set("True", forKey: "DataPopulated")
}
