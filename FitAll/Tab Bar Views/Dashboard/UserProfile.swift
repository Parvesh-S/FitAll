//
//  UserProfile.swift
//  FitAll
//
//  Created by keerthana on 12/1/20.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        VStack{
            Group {
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.pink)
                    .padding(.init(top: 40.0, leading: 5.0, bottom: 20.0, trailing: 5.0))
                
                
            }
            
            Group {
                Text("Name: \(userData.name)")
                    .padding()
                Text("Diet: \(userData.diet)")
                    .padding()
                Text("Weight: \(String(userData.weight))")
                    .padding()
                Text("Goal Weight: \(String(userData.goalWeight))")
                    .padding()
                Text("Daily Calorie Goal: \(String(userData.dailyCalorieGoal))")
                    .padding()
                Text("Daily Calorie Burnt Goal: \(String(userData.caloriesBurnedGoal))")
                    .padding()
            }
            
            Group {
                Spacer()
            }
            
            
        }
        .navigationBarItems(trailing:
                                NavigationLink(destination: EditProfile(), label: {
                                    Text("Edit")
                                }))
        .padding(.horizontal)
        .font(.system(size: 20))
    }
    
}

