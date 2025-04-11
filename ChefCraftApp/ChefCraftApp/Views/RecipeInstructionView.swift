//
//  RecipeInstructionView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/10.
//

import SwiftUI

struct RecipeInstructionView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @State private var scale: CGFloat = 0.8 // 初期は小さめ
    
    var recipe: Recipe
    var playerData: PlayerData
    @State var isShowingPopover: Bool = false
    @State var isCompleted: Bool = false
    @State var isCompletedButtonTap: Bool = false
    @State var shouldDismissInstructionView: Bool = false
    @Binding var shouldDismissToEntry: Bool
    var body: some View {
        ZStack {
            VStack {
                TitleView()
                Text(recipe.name)
                    .font(.title)
                Text(recipe.description)
                    .font(.callout)
                // 手順画面
                InstructionView(instructions: recipe.instructions,isCompleted: $isCompleted)
                
                if isCompleted {
                    // 完成したときの挙動・・・？
                    Button(action:{
                        // 挑戦中のレシピをUserDefaultsから削除する
//                        deleteUserDefaults()
                        isCompletedButtonTap = true
                        isCompleted = false
                        // CompletedMessageViewを出すフラグをtrueにして
                        // → CompletedMessageViewの中でアニメーション後に以下を実行
//                        shouldDismissToEntry = true // EntryViewまで戻す指示
//                        presentationMode.wrappedValue.dismiss() // 自分も閉じる
                    }){
                        Text("料理が完成した")
                            .titleStyle(color: .red)
                    }
                    .popover(isPresented: $isShowingPopover) {
                        Text("完成したらタップしてね")
                            .padding()
                            .foregroundStyle(.background)
                            .presentationBackground(.orange)
                            .presentationCompactAdaptation(.popover)
                    }
                }
            }
            .onAppear {
                // 2秒おきにポップアップ表示
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                    isShowingPopover = true
                    
                    // 自動的に非表示にする場合（例：2秒後に消す）
                    DispatchQueue.main.asyncAfter(deadline: .now() + 25.0) {
                        isShowingPopover = false
                    }
                }
            }
            .onChange(of: shouldDismissInstructionView) { newValue in
                if newValue {
                    shouldDismissToEntry = true
                    presentationMode.wrappedValue.dismiss()
                }
            }

            .padding()
            
            if isCompletedButtonTap {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                CompletedMessageView(recipe: recipe1, playerData: PlayerData(), rootDismiss: $shouldDismissInstructionView, isCompletedButtonTap: $isCompletedButtonTap)
                                .padding()
                                .background(Color.white) // 背景白にする場合
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 3)
                                )
                                .cornerRadius(12)
                                .scaleEffect(scale)
                
            }
        }
        
    }
    
}

#Preview {
    RecipeInstructionView(recipe: recipe1, playerData: PlayerData(), shouldDismissToEntry: .constant(false))
}

struct InstructionView: View {
    var instructions: [String]
    @State var count = 0
    @State var isAnimating: Bool = false
    @Binding var isCompleted: Bool
    let animationDuration: Double = 0.5
    @State private var animationTimer: Timer?

    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    isAnimating.toggle()
                    
                    // アニメーションを5秒後に止める
                    animationTimer?.invalidate() // 既存のタイマーを無効化
                    animationTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                        isAnimating = false
                    }
                    
                    if count + 1 >= instructions.count {
                        isCompleted = true
                        count = 0
                    } else {
                        count += 1
                    }
                }){
                    // 吹き出し風のボタン
                    Text(isCompleted ? "完成したかな？" : instructions[count])
                        .padding()
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .shadow(radius: 3)
                        )
                        .overlay(
                            // 吹き出しの三角部分
                            Triangle()
                                .fill(Color.white)
                                .frame(width: 20, height: 10)
                                .rotationEffect(.degrees(180))
                                .offset(x: 0, y: 10),
                            alignment: .bottom
                        )
                        .padding()
                }
                Image("chuka_chef")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .offset(y: -20)  // 画像を少し上に重ねる
                    .rotationEffect(.degrees(isAnimating ? 5 : -5)) // ちょっとした回転効果
                    .animation(isAnimating ? Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true) : .default, value: isAnimating)
            }
        }
    }
}

// 吹き出しの三角形部分をカスタムビューで作成
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}


struct CompletedMessageView: View {
    var recipe: Recipe

    var playerData: PlayerData
    @Binding var rootDismiss: Bool
    @Binding var isCompletedButtonTap: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showExpInfo = false
    @State private var isSparkling = false
    @State private var showEntryButton = false

    var body: some View {
        VStack {
            Spacer()

            // レシピ画像
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill) // 画像をアスペクト比を保ちながら枠にフィットさせる
                .frame(width: 300, height: 300)  // 正方形のサイズに指定
                .clipped()  // 画像の外側部分をトリミング
                .cornerRadius(20)
                .shadow(radius: 10)
            

            Spacer()

            if showExpInfo {
                VStack(spacing: 20) {
                    ZStack {
                        Text("レベル: \(playerData.level)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.yellow)
                            .scaleEffect(isSparkling ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isSparkling)

                        if isSparkling {
                            // キラキラ演出（簡易的な星アイコンを重ねる）
                            Image(systemName: "sparkles")
                                .foregroundStyle(.yellow)
                                .offset(x: -50, y: -20)
                                .opacity(0.8)
                            Image(systemName: "sparkles")
                                .foregroundStyle(.yellow)
                                .offset(x: 50, y: 20)
                                .opacity(0.8)
                        }
                    }

                    Text("+100 経験値！")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                .transition(.opacity)
                .padding()
            }

            if showEntryButton {
                Button(action: {
                    deleteUserDefaults()
                    isCompletedButtonTap = false  // モーダル非表示にする
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        rootDismiss = true         // RecipeInstructionView に戻す指示
                    }
                }) {
                    Text("エントリー画面へ")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            Spacer()
        }
        .onAppear {
            // 2秒後に経験値表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showExpInfo = true
                    isSparkling = true
                }

                // さらに1秒後にボタン表示
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        showEntryButton = true
                    }
                }
            }
        }
    }
    
    func deleteUserDefaults() {
        // 読み込み
        if let data = UserDefaults.standard.data(forKey: "currentRecipe"),
           let savedRecipe = try? JSONDecoder().decode(Recipe.self, from: data) {
            // savedRecipe を使う
        }
        
        if let encoded = try? JSONEncoder().encode(recipe) {
            UserDefaults.standard.removeObject(forKey: "currentRecipe")
        }
    }
}

#Preview {
    CompletedMessageView(recipe: Recipe(), playerData: PlayerData(), rootDismiss: .constant(false), isCompletedButtonTap: .constant(false))
}

struct TitleView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack{
            Text("No.007")
                .padding()
                .foregroundStyle(.white)
                .background(Color.red)
                .cornerRadiusStyle(color:Color.red)
            
            Rectangle()
                .foregroundStyle(.red)
                .frame(width:140 , height: 1,alignment: .bottom)
                .padding(.top, 40)
            Button(action: {
                //閉じるときは以下を呼び出す
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark.circle")
                    .frame(width: 50, height: 50)
                    .padding(.trailing,30)
            }
            
        }
    }
}
