//
//  Extensions.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/10.
//

import SwiftUI
// カスタムModifier（MyTitle）の定義
struct MyTitle: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CornerRadiusFrame: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
            content
                .padding()
                .background(Color.white) // 背景白にする場合
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(color, lineWidth: 3)
                )
                .cornerRadius(12)
            
        }
}

extension View {
    func titleStyle(color: Color) -> some View {
        self.modifier(MyTitle(color: color))
    }
    func cornerRadiusStyle(color: Color) -> some View {
        self.modifier(CornerRadiusFrame(color: color))
    }
}
#Preview("Loading") {
    Text("Hello, World!")
                .titleStyle(color: .blue)
    Text("角丸スタイル")
        .cornerRadiusStyle(color:Color.gray)
}

