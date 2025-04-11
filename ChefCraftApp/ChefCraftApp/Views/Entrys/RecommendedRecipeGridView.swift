//
//  RecommendedRecipeGridView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct RecommendedRecipeGridView: View {
    var recipes: [Recipe] = [recipe1, recipe2, recipe3, recipe4, recipe5]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var selectedRecipe: Recipe?
    @Binding var isPresented: Bool
    @Binding var showFullScreenCover: Bool
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
                    RecipeIconView(recipe: recipe, size: 80, onTap: {
                        selectedRecipe = recipe
                        isPresented = true
                    })
                }
                Button(action: {
                    showFullScreenCover = true
                }){
                    Text("レシピをもっと見る・・・")
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
#Preview {
    RecommendedRecipeGridView(selectedRecipe: .constant(Recipe()), isPresented: .constant(false), showFullScreenCover: .constant(false))
}

struct RecipeIconView: View {
    var recipe: Recipe
    var size: CGFloat = 150
    var fontsize: CGFloat = 20
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
                .font(.system(size: fontsize))
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
