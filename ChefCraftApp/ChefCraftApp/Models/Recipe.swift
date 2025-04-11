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
        self.instructions = ["卵とボールを用意する","フライパンに油をしいてあたためておく","卵を割ってボールの中でよく溶く", "あたたかいフライパンに溶き卵を少しずつ流し入れて巻く", "すべての溶き卵を流し入れて巻き終わったら完成"]
        self.skillType = skillType
        self.difficulty = difficulty
        self.category = category
    }
    
//    卵を割る - 卵を器に割り入れて、箸やフォークでよくかき混ぜてね。
//    フライパンを温める - 中火にして、フライパンをあたためる。油をひいて、キッチンペーパーで全体に広げよう。
//    卵を流し入れる - フライパンに卵を少しずつ流し入れ、全体に広げてね。卵が固まる前に巻き始めよう！
//    卵を巻く - 卵が固まり始めたら、端からフライ返しで少しずつ巻いていくよ。
//    最後まで巻いて完成 - 全部巻き終わったら、お皿に盛り付けて完成！お好みで醤油をかけて食べてね。
    
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

