//
//  RecipeDetailView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct RecipeIntroduceView: View {
    var recipe: Recipe
    var size: CGFloat = 100
    var playerData: PlayerData
    @State var isShowingPopover: Bool = false
    @State var instructionVisible: Bool = false
    @Binding var showPopup: Bool
    @Binding var showRecipeInProgress: Bool
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
            
            
            Button(action:{
                instructionVisible.toggle()
                withAnimation {
                    showPopup = false
                }
                showRecipeInProgress = true
                // 挑戦中のレシピをUserDefaultsに一時保存する
                save()
            }){
                Text("このレシピに挑戦する")
                    .titleStyle(color: .red)
            }
            .popover(isPresented: $isShowingPopover) {
                Text(popupMessage())
                    .padding()
                    .foregroundStyle(.background)
                    .presentationBackground(.orange)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .padding()
        .onAppear {
                    // 5秒おきにポップアップ表示
                    Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
                        isShowingPopover = true

                        // 自動的に非表示にする場合（例：2秒後に消す）
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            isShowingPopover = false
                        }
                    }
                }
    }
    
    func popupMessage() -> String {
        let strings = [
        "あと\(diff())つのレシピを達成したらでレベル\(playerData.level + 1)になるよ",
        "このレシピは\(recipe.time)秒で完成できます！",
        "次は、お料理フレンズになれるよ"
        ]
        
        return strings.randomElement() ?? "レシピをがんばって作ってみよう"
    }
    
    func diff() -> String {
        return String(Int(maxValue() - progress()))
    }
    
    func progress() -> Double {
        var progress = Double(playerData.recipeCount)
        for i in 1...playerData.level {
            if i == playerData.level { break }
            progress -= Double(i)
        }
        return progress
    }
    
    func maxValue() -> Double {
        if playerData.level < 5 {
            return Double(playerData.level)
        }
        return 10.00
    }
    
    func save() {
        // 保存
        if let encoded = try? JSONEncoder().encode(recipe) {
            UserDefaults.standard.set(encoded, forKey: "currentRecipe")
        }

        // 読み込み
        if let data = UserDefaults.standard.data(forKey: "currentRecipe"),
           let savedRecipe = try? JSONDecoder().decode(Recipe.self, from: data) {
            // savedRecipe を使う
        }

    }
}

#Preview {
    RecipeIntroduceView(recipe: Recipe(), playerData: PlayerData(),showPopup: .constant(false), showRecipeInProgress: .constant(false))
}

