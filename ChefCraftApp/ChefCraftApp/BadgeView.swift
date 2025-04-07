//
//  BadgeView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct BadgeView: View {
    var badge: Badge
    var size: CGFloat = 150
    var body: some View {
        VStack {
            BadgeImageView(imageName: badge.iconName,isBadge: badge.getBadge, size: size)
            Rectangle()
                .frame(width: size, height: 3)
                .foregroundColor(.gray)
            Text(badge.name)
                .font(.system(size: 20))
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

#Preview("画像あり") {
    BadgeView(badge: Badge(name: "卵割り名人", iconName: "cooking_color", description: "卵を1人できれいにわれること"))
}
#Preview("画像なし") {
    
}

struct BadgeImageView: View {
    var imageName: String = ""
    var isBadge: Bool = false
    var size: CGFloat = 150
    var body: some View {
        VStack(spacing: 0) {
            Image(isBadge ? imageName : "mark_question")
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.95, height: size * 0.95)
        }
    }
}
