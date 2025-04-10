//
//  Badge.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import Foundation

struct Badge:Identifiable {
    var id: UUID = UUID()
    var name: String
    var iconName: String
    var pinned: Bool = false
    var getBadge: Bool = false
    var wishBadge:Bool = false
    var description: String
    
    init(id: UUID, name: String, iconName: String, description: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.description = description
    }
    
    init (name: String, iconName: String, description: String) {
        self.name = name
        self.iconName = iconName
        self.description = description
    }
}
