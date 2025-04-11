//
//  NavigationState.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/10.
//

import Foundation

class NavigationState: ObservableObject {
    @Published var isEntryViewPresented = false
    @Published var didFinishEntry = false
}
