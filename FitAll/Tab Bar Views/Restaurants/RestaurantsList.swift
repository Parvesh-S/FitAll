//
//  RestaurantsList.swift
//  FitAll
//
//  Created by keerthana on 12/1/20.
//

import SwiftUI

struct RestaurantsList: View {
  
    @State private var requested = false;
    var body: some View {
        
        NavigationView {
            VStack{
                if (requested){
                    if (restaurantsFoundList.isEmpty) {
                        Text("Your Location Privacy settings for FitAll is disabled! Go to Privacy in phone settings to be able to use this restaurants feature of FitAll.")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .navigationBarTitle(Text("Nearby Restaurants"), displayMode: .inline)

                    }
                    else {
          
                        List {
                            ForEach(restaurantsFoundList){ rest in
                                NavigationLink(destination:
                                                RestaurantDetails(rest: rest)
                                ){
                                    RestaurantItem(rest: rest)
                                    
                                }
                            }//end of List
                            
                        }
                        .navigationBarTitle(Text("Nearby Restaurants"), displayMode: .inline)

                        
                    }
                }
            }
            .onAppear(perform: {
                if (restaurantsFoundList.isEmpty)
                {
                    obtainRestaurantDataByLocation()
                    self.requested = true;
                    
                }
            })

        }
    }
}
