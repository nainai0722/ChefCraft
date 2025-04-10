//
//  RecipeInstructionView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/10.
//

import SwiftUI

struct RecipeInstructionView: View {
    var recipe: Recipe
    var playerData: PlayerData
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("No.007")
                    .cornerRadiusStyle(color:Color.red)
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(width:200 , height: 1,alignment: .bottom)
                    .padding(.top, 40)
                    
                
            }
            Text(recipe.name)
                .font(.title)
            Text(recipe.description)
                .font(.callout)
            Image(recipe.iconName)
                .resizable()
                .scaledToFit()
        }
        .padding()
        
    }
}

#Preview {
    RecipeInstructionView(recipe: Recipe(), playerData: PlayerData())
}
