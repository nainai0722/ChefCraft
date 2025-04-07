//
//  PlayerData.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import Foundation

public struct PlayerData: Codable {
    public var name: String
    public var level: Int
    public var recipeCount: Int
    
    var progress: Double {
        Double(recipeCount) / 20.0 // 例: 総レシピ20として
    }
}
