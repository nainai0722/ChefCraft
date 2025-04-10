//
//  PlayerData.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import Foundation

public struct PlayerData: Codable {
    var name: String
    var level: Int
    var recipeIDs: [Int]
    var badgeIDs: [Int]
    var currentPosition: String
    public var recipeCount: Int
    
    var progress: Double {
        Double(recipeCount) / 20.0 // 例: 総レシピ20として
    }
    
    init (name: String, level: Int, recipeIDs: [Int], badgeIDs: [Int], currentPosition: String, recipeCount: Int) {
        self.name = name
        self.level = level
        self.recipeIDs = recipeIDs
        self.badgeIDs = badgeIDs
        self.currentPosition = currentPosition
        self.recipeCount = recipeCount
    }
    init () {
        self.name = "なな"
        self.level = 20
        self.recipeIDs = [1,2,3]
        self.badgeIDs = [1,2,3]
        self.currentPosition = "家庭料理人"
        self.recipeCount = 30
    }
    init (name: String) {
        self.name = name
        self.level = 20
        self.recipeIDs = [1,2,3]
        self.badgeIDs = [1,2,3]
        self.currentPosition = "家庭料理人"
        self.recipeCount = 30
    }
    init (name: String, level: Int, recipeCount: Int) {
        self.name = name
        self.level = level
        self.recipeIDs = [1,2,3]
        self.badgeIDs = [1,2,3]
        self.currentPosition = "家庭料理人"
        self.recipeCount = recipeCount
    }
    

}
