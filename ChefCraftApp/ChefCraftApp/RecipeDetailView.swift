//
//  RecipeDetailView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    var size: CGFloat = 100
    @State var instructionVisible: Bool = false
    var body: some View {
        VStack{
            HStack {
                Image(recipe.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.95, height: size * 0.95)
                Text(recipe.name)
            }
            Button(action:{
                instructionVisible.toggle()
            }){
                Text("このレシピに挑戦する")
            }
            ForEach(recipe.instructions, id:\.self){ instruction in
                //これだと動的すぎる・・・
                if instructionVisible {
                    Text(instruction)
                }
            }
            
            Text("達成できたら、お料理フレンズに昇格するよ")
                .padding()
                .background(Color.white) // 背景白にする場合
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 3)
                )
                .cornerRadius(12)
            Text("あと３つのレシピに取り組めば、レベル６")
                .padding()
                .background(Color.white) // 背景白にする場合
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 3)
                )
                .cornerRadius(12)
            
        }
        .onAppear(){
            print("受け取ったレシピ")
            print(recipe.name)
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe())
}
