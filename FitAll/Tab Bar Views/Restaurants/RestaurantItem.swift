//
//  RestaurantItem.swift
//  FitAll
//
//  Created by keerthana on 12/1/20.
//

import SwiftUI

struct RestaurantItem: View {
    let rest: Restaurant
    var body: some View {
        getImageFromUrl(url: rest.imageid, defaultFilename: "restaurant")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80.0, height: 80.0)
            
        VStack(alignment:.leading) {
            Text(rest.name)
            Text("\(rest.address)")
        }
    }
    
}

