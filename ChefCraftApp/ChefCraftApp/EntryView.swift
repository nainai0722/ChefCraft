//
//  EntryView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct EntryView: View {
    @State var selectedRecipe: Recipe?
    @State var showPopup: Bool = false
    var body: some View {
        VStack {
            LevelDisplay(playerData: PlayerData(name: "ゆの", level: 5, recipeCount: 10))
                .padding(.horizontal)
            RecommendedRecipeGridView(selectedRecipe: $selectedRecipe, showPopup: $showPopup)
                .padding(.horizontal)
        }
        .sheet(isPresented: $showPopup) {
            if let recipe = selectedRecipe {
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}

#Preview {
    EntryView()
}
