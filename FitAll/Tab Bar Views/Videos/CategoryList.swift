//
//  CategoryList.swift
//  FitAll
//
//  Created by keerthana on 11/30/20.
//

import SwiftUI

struct CategoryList: View {
    let choices = ["Full Body", "Upper Body", "Lower Body", "Legs", "Shoulders", "Chest", "Triceps", "Biceps", "Glutes", "HIIT", "Pilates", "Yoga"]
    @State var isTapped = false
    @EnvironmentObject var userData: UserData
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showCaloriesBurntUpdatedAlert = false
    
    @State private var caloriesEntered = ""
    // Define formatter before it is used
    let numFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        return numberFormatter
    }()
    var body: some View {
        NavigationView {
            
            VStack {
                self.inputCaloriesField
                
                List {
                    ForEach(0 ..< choices.count, id: \.self) { index in
                        
                        NavigationLink(
                            destination: VideoList(input: choices[index]),
                            label: {
                                Text(choices[index])
                            })
                    }
                }
            }.navigationBarTitle(Text("Workout Videos"), displayMode: .inline)
            
        }
        .alert(isPresented: $showCaloriesBurntUpdatedAlert, content: { self.caloriesUpdatedAlert })

        
        
    }
    
    func dismissKeyboard() {

            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

        }
    func searchForVideos(input: String)
    {
        obtainYoutubeData(query: input.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    
    var inputCaloriesField: some View {
        
        HStack {
            Text("Calories Burnt: ")
            TextField("Calories", text: $caloriesEntered)
                .keyboardType(.numberPad)
            
            // Button to clear the text field
            Button(action: {
                if (!caloriesEntered.isEmpty)
                {
                    self.showCaloriesBurntUpdatedAlert = true
                    userData.updateCaloriesBurned(calories: Int(caloriesEntered)!)
                    self.dismissKeyboard();
                    
                }
                
                
            }) {
                Image(systemName: "plus.circle")
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
            }
        }   // End of HStack
        .padding()
    }
    
    
    var caloriesUpdatedAlert: Alert {

           Alert(title: Text("Calories Burnt Updated!"),
                 message: Text("\(self.caloriesEntered) calories have been added to your calories burnt for the day!"),
                 dismissButton: .default(Text("OK")) {
                    self.showCaloriesBurntUpdatedAlert = false
                    self.presentationMode.wrappedValue.dismiss()
                    self.caloriesEntered = ""
                 })

       }
}

