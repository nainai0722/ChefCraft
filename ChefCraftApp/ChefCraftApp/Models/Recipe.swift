//
//  Recipe.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import Foundation

struct Recipe:Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var iconName: String
    var imageName: String
    var pinned: Bool = false
    var completed: Bool = false
    var tryCount: Int = 0
    var time :String = "5分"
    var ingredients: [String] = []
    var instructions: [String] = []
    var description: String
    
    // 一覧をセクション分けする際に使う
    var skillType: SkillType
    var difficulty: Difficulty
    var category: Category
    
    init (name: String, iconName: String, imageName: String, time:String, tryCount: Int, description: String, skillType: SkillType, difficulty: Difficulty,category: Category) {
        self.name = name
        self.iconName = iconName
        self.imageName = imageName
        self.time = time
        self.tryCount = 0
        self.description = description
        
        self.skillType = skillType
        self.difficulty = difficulty
        self.category = category
    }
    
    init () {
        self.name = "カレー"
        self.iconName = "curry"
        self.imageName = ""
        self.time = "30分"
        self.difficulty = .hard
        self.tryCount = 0
        self.ingredients = ["人参","玉ねぎ","じゃがいも"]
        self.instructions = ["野菜を切る","炒める","煮込む"]
        self.description = "特になし"
        self.skillType = .cutting
        self.difficulty = .withAdult
        self.category = .dinner
    }
}

enum SkillType: String, CaseIterable, Identifiable, Codable {
    var id: Self { self }
    
    case cutting = "食材を切る"
    case frying = "炒める"
    case deepFrying = "揚げる"
    case simmering = "煮込む"
    case prepping = "下ごしらえをする"
}

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    var id: Self { self }
    
    case easy = "簡単"
    case medium = "ちょっと難しい"
    case hard = "難しい"
    case withAdult = "大人と一緒に作る"
}

enum Category: String, CaseIterable, Identifiable, Codable {
    var id: Self { self }
    
    case breakfast = "朝ご飯"
    case lunch = "昼ご飯"
    case dinner = "夕ご飯"
    case snack = "おやつ"
}

