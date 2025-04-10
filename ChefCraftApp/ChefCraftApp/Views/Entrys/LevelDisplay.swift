//
//  LevelDisplay.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/07.
//

import SwiftUI

struct LevelDisplay: View {
    var playerData: PlayerData
    var size: CGFloat = 100
    @State private var isShowingPopover = false
    @State private var progressPopover = true
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                VStack(alignment:.leading) {
                    Text(playerData.name)
                        .font(.title)
                    Text("今のあなたは・・・")
                    Text(playerData.currentPosition)
                        .font(.title)
                    Text("Level: \(playerData.level)")
                }
                Spacer()
                Image("chuka_chef")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.95, height: size * 0.95)
            }

            ProgressView(value: progress(), total: maxValue())
                .progressViewStyle(.linear)
                
            
            Button("Show Popover") {
              isShowingPopover = true
            }
            .popover(isPresented: $isShowingPopover) {
                Text("あと\(diff())つのレシピを達成したらでレベル\(playerData.level + 1)になるよ")
                    .padding()
                    .foregroundStyle(.background)
                    .presentationBackground(.orange)
                    .presentationCompactAdaptation(.popover)
            }
        }
        .padding(.leading,10)
        .padding()
        .background(Color.white) // 背景白にする場合
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 3)
        )
        .cornerRadius(12)
    }
    
    func diff() -> String {
        return String(Int(maxValue() - progress()))
    }
    
    func progress() -> Double {
        var progress = Double(playerData.recipeCount)
        for i in 1...playerData.level {
            if i == playerData.level { break }
            progress -= Double(i)
        }
        print("プログレス\(progress)")
        print("調整した値\(max(0, min(progress, maxValue())))")
        return max(0, min(progress, maxValue()))
    }
    
    func maxValue() -> Double {
        if playerData.level < 5 {
            return Double(playerData.level)
        }
        return 10.00
    }
    
}

#Preview {
    LevelDisplay(playerData: PlayerData(name: "ゆの"))
    Spacer()
}


#Preview ("Level1"){
    LevelDisplay(playerData: PlayerData(name: "ゆの",level: 1,recipeCount: 1))
    Spacer()
}
#Preview ("Level2"){
    LevelDisplay(playerData: PlayerData(name: "ゆの",level: 2,recipeCount: 3))
    Spacer()
}

#Preview ("Level2"){
    LevelDisplay(playerData: PlayerData(name: "ゆの",level: 5,recipeCount: 15))
    Spacer()
}
