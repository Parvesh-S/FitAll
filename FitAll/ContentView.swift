//
//  ContentView.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/27/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData

    var body: some View {
        TabView {
            Dashboard()
                .tabItem{
                    Image(systemName: "person")
                    Text("Dashboard")
                }
            Foods()
                .tabItem{
                    Image(systemName: "scroll")
                    Text("Food Log")
                }
            Recipes()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Recipes")
                }
            CategoryList()
                .tabItem {
                    Image(systemName: "bolt.heart")
                    Text("Exercises")
                }
            RestaurantsList()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Restaurants")
                }
            
        }   // End of TabView
        .accentColor(.pink)
    }
}
