//
//  RecipesButton.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 11/28/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct RecipesButton: View {
    
    @State private var searchCompleted = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("get recipes")) {
            Button(action: {
                getRecipesData(searchTag: "vegan")
                searchCompleted = true
            }) {
                Text("Get Recipes")
            }
            }
            
            if searchCompleted {
                Section(header: Text("list recipes found")) {
                NavigationLink(destination: showSearchResults) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Recipes Found")
                            .font(.system(size: 16))
                    }
                }
                .frame(minWidth: 300, maxWidth: 500)
                }
            }
        }
        }
    }
    
    var showSearchResults: some View {
        return AnyView(Recipes())
    }
}
