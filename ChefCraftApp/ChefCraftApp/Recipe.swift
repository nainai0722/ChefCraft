//
//  Recipe.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import Foundation

struct Recipe:Identifiable {
    var id: UUID = UUID()
    var name: String
    var iconName: String
    var pinned: Bool = false
    var completed: Bool = false
    var tryCount: Int = 0
    var time :String = "5分"
    var difficulty: String = " facile"
    var ingredients: [String] = []
    var instructions: [String] = []
    var description: String
    
    init(id: UUID, name: String, iconName: String, tryCount: Int, description: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.tryCount = tryCount
        self.description = description
    }
    
    init (name: String, iconName: String, time:String, difficulty: String, tryCount: Int, description: String) {
        self.name = name
        self.iconName = iconName
        self.time = time
        self.difficulty = difficulty
        self.tryCount = 0
        self.description = description
    }
    init () {
        self.name = "カレー"
        self.iconName = "curry"
        self.time = "30分"
        self.difficulty = "なかなか難しい"
        self.tryCount = 0
        self.ingredients = ["人参","玉ねぎ","じゃがいも"]
        self.instructions = ["野菜を切る","炒める","煮込む"]
        self.description = "特になし"
    }
    
}
