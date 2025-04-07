//
//  LevelDisplay.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct LevelDisplay: View {
    var playerData: PlayerData
    @State var progress = 20.00
    var body: some View {
        VStack {
            Text(playerData.name)
                .font(.title)
            Text("Level: \(playerData.level)")
            Text("Recipes: \(playerData.recipeCount)")
            ProgressView(value: Double(playerData.recipeCount), total: Double(20))
                .progressViewStyle(.linear)
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
    LevelDisplay(playerData: PlayerData(name: "ゆの", level: 5, recipeCount: 10))
}
