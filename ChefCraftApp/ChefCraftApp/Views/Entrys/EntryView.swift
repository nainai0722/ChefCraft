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
    @State var showPopup2: Bool = false
    @State var showFullScreenCover: Bool = false
    @State var showRecipeInProgress: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                LevelDisplay(playerData: PlayerData(name: "ゆの"))
                    .padding(.horizontal)
                RecommendedRecipeGridView(selectedRecipe: $selectedRecipe, showPopup: $showPopup,showFullScreenCover: $showFullScreenCover)
                    .padding(.horizontal)
            }
            .sheet(isPresented: $showPopup) {
                if let recipe = selectedRecipe {
                    RecipeIntroduceView(recipe: recipe, playerData: PlayerData(),showPopup: $showPopup,showRecipeInProgress: $showRecipeInProgress)
                }
            }
            .popover(isPresented: $showFullScreenCover) {
                RecipeGropingListView(showPopup: $showPopup2)
                    .presentationCompactAdaptation(
                        .fullScreenCover)
            }
        }
    }
}

#Preview {
    EntryView()
}
