//
//  EditProfile.swift
//  FitAll
//
//  Created by keerthana on 12/5/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI
import Combine

struct EditProfile: View {
    private var diets = ["Omnivore", "Gluten Free", "Ketogenic", "Vegetarian", "Lacto-Vegetarian", "Ovo-Vegetarian", "Vegan", "Pescetarian", "Paleo", "Primal", "Whole30"]
    
    @EnvironmentObject var userData: UserData
    
    let numFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        return numberFormatter
    }()
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showUserUpdatedAlert = false
    
    @State private var name = "";
    @State private var selectedIndex = getIndexOfCurrentDiet();
    @State private var weight = ""
    @State private var goalWeight = ""
    @State private var calorieGoal = ""
    @State private var burnGoal = ""
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField( userData.name, text: $name)
            }
            
            Section(header: Text("Diet")) {
                Picker("Answer:", selection: $selectedIndex) {
                    ForEach(0 ..< diets.count, id: \.self) {
                        Text(self.diets[$0])
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            
            Section(header: Text("Current Weight")) {
                TextField( String(userData.weight), text: $weight)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Goal Weight")) {
                TextField( String(userData.goalWeight), text: $goalWeight)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Daily Calorie Goal")) {
                TextField( String(userData.dailyCalorieGoal), text: $calorieGoal)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Daily Calorie Burnt Goal")) {
                TextField( String(userData.caloriesBurnedGoal), text: $burnGoal)
                    .keyboardType(.numberPad)
            }
        }
        .alert(isPresented: $showUserUpdatedAlert, content: { self.userDataUpdatedAlert })
        .navigationBarItems(trailing:
            Button(action: {
                if !name.isEmpty {
                    userData.updateName(name: name)
                }
                if !weight.isEmpty {
                    userData.updateWeight(weight: Int(weight)!)
                }
                if !goalWeight.isEmpty {
                    userData.updateGoalWeight(goal: Int(goalWeight)!)
                }
                if !calorieGoal.isEmpty {
                    userData.updateCalorieGoal(goal: Int(calorieGoal)!)
                }
                if !burnGoal.isEmpty {
                    userData.updateCalorieBurnGoal(goal: Int(burnGoal)!)
                }
                
                if (selectedIndex != getIndexOfCurrentDiet())
                {
                    userData.updateDiet(diet: diets[selectedIndex])
                    getRecipesData()
                }
            
                self.showUserUpdatedAlert = true
          
            }) {
                Text("Update")
            })
    }
    
    var userDataUpdatedAlert: Alert {

           Alert(title: Text("User Profile Updated!"),
                 message: Text("User information has been updated and all changes will be shown in the application"),
                 dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                 })

       }
}
