//
//  AddFood.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI
import CoreData

struct AddFood: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var categoryIndex = 1;
    @State private var showFoodAddedAlert = false
    @State private var showMissingDataAlert = false
    let categories = ["Breakfast", "Lunch", "Dinner", "Snack"]
    
    // Primary Trip Information
    @State private var name = ""
    @State private var calories = ""
    @State private var cost = 0.0
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    let caloriesFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        return numberFormatter
    }()
    
    /*
     --------------------------
     MARK: - Food Added Alert
     --------------------------
     */
    var foodAddedAlert: Alert {
        Alert(title: Text("Food Added!"),
              message: Text("Your food log has been updated with a new item!"),
              dismissButton: .default(Text("OK")) {
                
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
              })
    }
    
    /*
     --------------------------
     MARK: - Input Data missing Alert
     --------------------------
     */
    var missingInputAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("Required Data: name and calories"),
              dismissButton: .default(Text("OK")) {
                
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
              })
    }
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("Food Name")) {
                    TextField("Enter food name", text: $name)
                }
                Section(header: Text("Food Calories")) {
                    TextField("", text: $calories)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Food Category")) {
                    Picker("Category", selection: $categoryIndex) {
                        ForEach(0 ..< categories.count, id: \.self) {
                            Text(self.categories[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            .alert(isPresented: $showMissingDataAlert, content: { self.missingInputAlert })
        }   // End of Form
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .font(.system(size: 14))
        .alert(isPresented: $showFoodAddedAlert, content: { self.foodAddedAlert })
        .navigationBarTitle(Text("Add Food"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                if(self.inputDataValidated())
                {
                    addNewFood()
                    self.showFoodAddedAlert = true
                }
                else {
                    self.showMissingDataAlert = true;
                }
            }) {
                Text("Save")
            })
        
    }
    
    
    func inputDataValidated() -> Bool
    {
        if (self.calories.isEmpty || self.name.isEmpty)
        {
            return false;
        }
        return true;
    }
    
    func addNewFood() {
        let nFood = Food(context: managedObjectContext)
        
        nFood.calories = NSNumber(value: Int(calories)!)
        nFood.category = categories[categoryIndex] 
        nFood.name = name
        
        userData.updateCaloriesConsumed(calories: Int(calories)!)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
    }
}
