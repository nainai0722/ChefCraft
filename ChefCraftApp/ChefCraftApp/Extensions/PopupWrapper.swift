//
//  PopupWrapper.swift
//  ChefCraftApp
//
//  Created by 指原奈々 on 2025/04/09.
//

import SwiftUI

struct PopupWrapper<Content: View>: View {
    let content: Content
    @Binding var isPresented: Bool
    @State private var scale: CGFloat = 0.8

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }

                content
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            scale = 1.0
                        }
                    }
            }
            .transition(.opacity)
        }
    }
}

//#Preview {
//    PopupWrapper()
//}
