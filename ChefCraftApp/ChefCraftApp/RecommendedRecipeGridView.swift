//
//  RecommendedRecipeGridView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct RecommendedRecipeGridView: View {
    var recipes: [Recipe] = [recipe1, recipe2]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var selectedRecipe: Recipe?
    @Binding var showPopup: Bool
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
                    RecipeIconView(recipe: recipe, size: 80, onTap: {
                        selectedRecipe = recipe
                        showPopup = true
                    })
                }
            }
        }
        .padding()
        .background(Color.white) // 背景白にする場合
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 3)
        )
        .cornerRadius(12)
    }
}

let recipe1 = Recipe(name: "卵焼き", iconName: "", time: "出汁と卵を解いて丁寧に巻いて焼き上げたレシピです。", difficulty: "15分", tryCount: 10, description: "特になし")
let recipe2 = Recipe(name: "スクランブルエッグ", iconName: "", time: "5分", difficulty: "easy", tryCount: 5, description: "特になし")

//#Preview {
//    RecommendedRecipeGridView(selectedRecipe: <#Binding<Recipe?>#>, showPopup: <#Binding<Bool>#>)
//}


struct RecipeIconView: View {
    var recipe: Recipe
    var size: CGFloat = 150
    let onTap: () -> Void
    var body: some View {
        VStack {
            Button(action:{
                print(recipe.name + "tap")
                onTap()
            }) {
                VStack(spacing: 0) {
                    Image(recipe.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size * 0.95, height: size * 0.95)
                }
            }
            Text(recipe.name)
                .font(.system(size: 20))
        }
        .frame(width: size, height: size)
        .padding()
        .background(Color.white) // 背景白にする場合
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 3)
        )
        .cornerRadius(12)
    }
}
