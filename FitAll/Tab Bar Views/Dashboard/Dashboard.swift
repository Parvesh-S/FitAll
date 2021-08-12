//
//  Dashboard.swift
//  FitAll
//
//  Created by keerthana on 12/1/20.
//

import SwiftUI

struct Dashboard: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var sliderValue = Double(UserDefaults.standard.integer(forKey: "waterConsumed"))
    @EnvironmentObject var userData: UserData
    @FetchRequest(fetchRequest: Food.allFoodFetchRequest()) var allFoods: FetchedResults<Food>
    @State private var refresh = false;
    
    var body: some View {
        NavigationView {
                VStack {
                    Text("Hi \(userData.name)!")
                        .font(.custom("Helvetica Neue", size: 35))
                        .padding()
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                        .padding()
                    
                    Group {
                        Text("Net Calories: \(String(userData.caloriesConsumed - userData.caloriesBurned)) kCal")
                            .font(.title3)
                            .padding(.bottom, 3)
                        
                        Text("Calories Consumed: \(userData.caloriesConsumed) out of \(userData.dailyCalorieGoal) kCal")
                            .font(.title3)
                            .padding(.bottom, 3)
                        
                        Text("Calories Burned: \(userData.caloriesBurned) out of \(userData.caloriesBurnedGoal) kCal")
                            .font(.title3)
                            .padding(.bottom, 10)
                    }
                     
                    Spacer()
                        
                    HStack {
                        Spacer()
                        ZStack {
                            movingRectangle
                            Image("glass")
                                .resizable()
                                .frame(width: 101, height: CGFloat(3*64))
                                .foregroundColor(.white)
                            let hello = Int(sliderValue)
                            Text("\(hello) oz.")
                        }
                        
                        Slider(value: $sliderValue, in: 0.0...64.0, step: 0.5, onEditingChanged: { data in
                            userData.updateWaterConsumed(water: Int(sliderValue))
                        })
                            .rotationEffect(.degrees(-90.0), anchor: .center)
                            .frame(width:CGFloat(3*64))
                        Spacer()
                    }
                    
                    .navigationBarTitle(Text("Dashboard"), displayMode: .inline)
                    .navigationBarItems(trailing:
                                            NavigationLink(destination: UserProfile(), label: {
                                                Image(systemName: "person.circle")
                                                    .imageScale(.medium)
                                                    .font(Font.title.weight(.regular))
                                                    .foregroundColor(.pink)
                                            })
                    )
                    Spacer()
                
                }
            }
    }
    
    var movingRectangle: some View {
        VStack {
            Rectangle()
                // Turquoise RGB(64, 224, 208)
                .fill(Color(red: 255/255, green: 255/255, blue: 255/255))
                .frame(width: 100, height: CGFloat(3*(64-sliderValue)))
                .opacity(0.0)
            //
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 105/255, green: 187/255, blue: 219/255))
                .frame(width: 100, height: CGFloat(3*sliderValue))
            
        }
    }
}
