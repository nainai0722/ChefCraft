//
//  RecipeListView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/08.
//

import SwiftUI
// すべてのレシピ一覧
struct RecipeListView: View {
    @State var selectedRecipe: Recipe?
    @State var showPopup: Bool = false
    @State var showFullScreenCover = false
    @State var showRecipeInProgress = false
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>

    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    //閉じるときは以下を呼び出す
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle")
                        .frame(width: 50, height: 50)
                        .padding(.trailing,30)
                }
            }
            RecipeGridView(selectedRecipe: $selectedRecipe, showFullScreenCover: $showFullScreenCover)
        }
        .popover(isPresented: $showFullScreenCover) {
            if let recipe = selectedRecipe {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            //閉じるときは以下を呼び出す
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "xmark.circle")
                                .frame(width: 50, height: 50)
                                .padding(.trailing,30)
                        }
                    }
                    RecipeIntroduceView(recipe: recipe, playerData: PlayerData(),showPopup: $showPopup, showRecipeInProgress: $showRecipeInProgress)
                        .padding()
                        .presentationCompactAdaptation(.fullScreenCover)
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}


struct RecipeGridView: View {
    var recipes: [Recipe] = [recipe1, recipe2, recipe3, recipe4]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var selectedRecipe: Recipe?
    @Binding var showFullScreenCover: Bool
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(recipes) { recipe in
                    RecipeIconView2(recipe: recipe, size: 80, onTap: {
                        selectedRecipe = recipe
                        showFullScreenCover = true
                    })
                }
            }
        }
//        .padding()
//        .background(Color.white) // 背景白にする場合
//        .overlay(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.gray, lineWidth: 3)
//        )
//        .cornerRadius(12)
    }
}



struct RecipeIconView2: View {
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
