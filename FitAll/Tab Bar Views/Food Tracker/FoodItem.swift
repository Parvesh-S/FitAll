//
//  FoodItem.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct FoodItem: View {
    let food: Food
   
    var body: some View {
        HStack {
            Image(food.category ?? "FoodDefaultPic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
                .padding(.leading, 10)
           
            Spacer()
            VStack(alignment: .leading) {
                Text("\(food.name!)")
                    .padding(.bottom, 3)
                Text("\(food.calories!) kCal")
                    .padding(.bottom, 3)
                Text("\(food.category!)")
                    .padding(.bottom, 3)
            }
            Spacer()
            .font(.system(size: 14))
            .padding(.leading, 10)
        }
    }
}
