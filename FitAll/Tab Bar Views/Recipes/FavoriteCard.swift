//
//  FavoriteCard.swift
//  FitAll
//
//  Created by Parvesh Samayamanthula on 12/2/20.
//  Copyright © 2020 Parvesh Samayamanthula. All rights reserved.
//

import SwiftUI

struct FavoriteCard: View {
    let recipe: Recipe
    @EnvironmentObject var userData: UserData
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var offset = 0
    
    // Same as RecipeCard, except now we don't need to include the dislike/like buttons becausethe user has already saved it to their favorites
    var body: some View {
        HStack{
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                getImageFromUrl(url: recipe.picture!, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 3.6))
                    .cornerRadius(15)
                    .opacity(0.6)
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content:
                        {
                            VStack(alignment: .leading,spacing: 18){
                                HStack{
                                    Text(recipe.name!)
                                        .font(.system(size: 24))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }
                            .frame(width: calculateWidth() - 40)
                            .padding(.leading,20)
                            .padding(.bottom,20)
                        })
            }
            
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .padding(.leading, 10)
        .offset(y: CGFloat(self.offset))
    }
    
    // Calculates the with of each card, based on the dimensions of the phone's screen. This ensures each card is the same size and scalable to iOS devices of different sizes.
    func calculateWidth()->CGFloat{
        
        let screen = UIScreen.main.bounds.width - 25
        
        let width = screen - (2 * 60)
        
        return width
    }
}
