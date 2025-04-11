//
//  RecipeGropingListView.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/09.
//

import SwiftUI

let recipes: [Recipe] = [recipe1, recipe2, recipe3, recipe4,recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13, recipe14, recipe15]

struct RecipeGropingListView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State var  groupedRecipes: [SkillType: [Recipe]] = [:]
    @Binding var shouldDismissToEntry: Bool
    @State var showRecipeInProgress = false
    
    enum SectionInfo: String, CaseIterable, Identifiable {
        case skill, difficulty, category
        var id: Self { self }
    }

    @State private var selectedSection: SectionInfo = .skill
    @Binding var showPopup: Bool
    @State var selectedRecipe: Recipe?
    @State private var scale: CGFloat = 0.8 // 初期は小さめ
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Menu {
                        Button("スキルごとに表示") { selectedSection = .skill }
                        Button("難易度ごとに表示") { selectedSection = .difficulty }
                        Button("カテゴリごとに表示") { selectedSection = .category }
                    } label: {
                        Image(systemName: "list.bullet")
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 30)
                    }
                    Spacer()
                    
                    Button(action: {
                        //閉じるときは以下を呼び出す
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "xmark.circle")
                            .frame(width: 50, height: 50)
                            .padding(.trailing,30)
                    }
                }
                
                switch selectedSection {
                case .skill:
                    SkillSectionView(showPopup: $showPopup, selectedRecipe:$selectedRecipe)
                case .category:
                    CategorySectionView(showPopup: $showPopup, selectedRecipe:$selectedRecipe)
                case .difficulty:
                    DifficultySectionView(showPopup: $showPopup, selectedRecipe:$selectedRecipe)
                }
                Spacer()
            }
            if showPopup, let selectedRecipe = selectedRecipe {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                RecipeIntroduceView(recipe: selectedRecipe, playerData: PlayerData(), isPresented: $showPopup, showRecipeInProgress: $showRecipeInProgress)
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
        .fullScreenCover(isPresented: $showRecipeInProgress) {
            RecipeInstructionView(recipe: selectedRecipe!, playerData: PlayerData(), shouldDismissToEntry: $shouldDismissToEntry)
                .scaleEffect(scale)
        }
        .onChange(of: showPopup) { value in
            scale = 1.2 // 表示時にやや大きく
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                scale = 1.0 // そのあとバウンスして元の大きさへ
            }
        }
        .zIndex(1) // 他より前面に出す
    }
}

#Preview {
    RecipeGropingListView(shouldDismissToEntry: .constant(false), showPopup: .constant(false))
}

struct SkillSectionView: View {
    var groupedRecipes = Dictionary(grouping: recipes){ $0.skillType}
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var showPopup: Bool
    @Binding var selectedRecipe: Recipe?
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment:.leading) {
                    ForEach(SkillType.allCases, id:\.self) {
                        skill in
                        if let sectionRecipe =  groupedRecipes[skill], !sectionRecipe.isEmpty {
                            Section(header:
                                        SectionHeaderView(sectionTitle: skill.rawValue)
                            ){
                                LazyVGrid(columns: columns) {
                                    ForEach(sectionRecipe){ recipe in
                                        RecipeIconView(recipe: recipe,size: 80, fontsize:10, onTap: {
                                            showPopup = true
                                            selectedRecipe = recipe
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CategorySectionView: View {
    var groupedRecipes = Dictionary(grouping: recipes){ $0.category}
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var showPopup: Bool
    @Binding var selectedRecipe: Recipe?
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment:.leading) {
                    ForEach(Category.allCases, id:\.self) {
                        skill in
                        if let sectionRecipe =  groupedRecipes[skill], !sectionRecipe.isEmpty {
                            Section(header:
                                        SectionHeaderView(sectionTitle: skill.rawValue)
                            ){
                                LazyVGrid(columns: columns) {
                                    ForEach(sectionRecipe){ recipe in
                                        RecipeIconView(recipe: recipe,size: 80, fontsize:10, onTap: {
                                            showPopup = true
                                            selectedRecipe = recipe
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DifficultySectionView: View {
    var groupedRecipes = Dictionary(grouping: recipes){ $0.difficulty}
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var showPopup: Bool
    @Binding var selectedRecipe: Recipe?
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment:.leading) {
                    ForEach(Difficulty.allCases, id:\.self) {
                        skill in
                        if let sectionRecipe =  groupedRecipes[skill], !sectionRecipe.isEmpty {
                            Section(header:
                                        SectionHeaderView(sectionTitle: skill.rawValue)
                            ){
                                LazyVGrid(columns: columns) {
                                    ForEach(sectionRecipe){ recipe in
                                        RecipeIconView(recipe: recipe,size: 80, fontsize:10, onTap: {
                                            showPopup = true
                                            selectedRecipe = recipe
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



struct SectionHeaderView: View {
    var sectionTitle: String
    var size :CGFloat = 50
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(.gray.opacity(0.3))
                        .frame(width: size, height: size)
                    Image("cooking02_itameru")
                        .resizable()
                        .frame(width: size, height: size)
                }
                .frame(width: size, height: size)
                Text(sectionTitle)
                    .font(.title)
            }
        }
    }
}
