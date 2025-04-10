//
//  BadgeCollectionView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct BadgeCollectionView: View {
    var badges: [Badge] = [badges1,badges2, badges3,badges4]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(badges) { badge in
                    BadgeView(badge: badge)
                }
            }
        }
    }
}

let badges1: Badge = Badge(name: "卵割り名人", iconName: "cooking_color", description: "卵を1人できれいにわれること")
let badges2: Badge = Badge(name: "卵焼きマスター", iconName: "cooking_color", description: "卵焼きを最高に仕上げること")
let badges3: Badge = Badge(name: "卵割り名人", iconName: "cooking_color", description: "卵を1人できれいにわれること")
let badges4: Badge = Badge(name: "卵焼きマスター", iconName: "cooking_color", description: "卵焼きを最高に仕上げること")

#Preview {
    BadgeCollectionView()
}


struct VerticalSmileys: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
         ScrollView {
             LazyVGrid(columns: columns) {
                 ForEach(0x1f600...0x1f679, id: \.self) { value in
                     Text(String(format: "%x", value))
                     Text(emoji(value))
                         .font(.largeTitle)
                 }
             }
         }
    }

    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}
