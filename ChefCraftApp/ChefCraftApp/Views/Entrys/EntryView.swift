//
//  EntryView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct EntryView: View {
    @State var selectedRecipe: Recipe?
    @State var isPresented: Bool = false
    @State var showPopup2: Bool = false
    @State var showFullScreenCover: Bool = false
    @State var showRecipeInProgress: Bool = false
    
    @State var shouldDismissToEntry = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                LevelDisplay(playerData: PlayerData(name: "ゆの"))
                    .padding(.horizontal)
                RecommendedRecipeGridView(selectedRecipe: $selectedRecipe, isPresented: $isPresented, showFullScreenCover: $showFullScreenCover)
                    .padding(.horizontal)
            }
            .sheet(isPresented: $isPresented) {
                if let recipe = selectedRecipe {
                    RecipeIntroduceView(recipe: recipe, playerData: PlayerData(),isPresented: $isPresented,showRecipeInProgress: $showRecipeInProgress)
                }
            }
            .popover(isPresented: $showFullScreenCover) {
                RecipeGropingListView(shouldDismissToEntry: $shouldDismissToEntry, showPopup: $showPopup2)
                    .presentationCompactAdaptation(
                        .fullScreenCover)
            }
            .onChange(of: shouldDismissToEntry) { newValue in
                if newValue {
                    showFullScreenCover = false // popoverを閉じる
                }
            }
        }
    }
}

#Preview {
    EntryView()
}
