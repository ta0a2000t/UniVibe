//
//  ViewExtensions.swift
//  UniVibe
//
//  Created by Taha Al on 8/22/23.
//

import SwiftUI

struct LinearGradientBackground: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [topColor, bottomColor, topColor]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all).ignoresSafeArea(.all)
            )
    }
    
    
    var topColor: Color {
        return Color(UIColor.systemBackground).opacity(0.1)
    }
    
    var bottomColor: Color {
        return Color.purple.opacity(0.7)
    }
    
    var titleColor: Color {
        if colorScheme == .dark {
            return .purple
        } else {
            return .purple
        }
    }
    
}

extension View {
    func linearGradientBackground() -> some View {
        self.modifier(LinearGradientBackground())//.modifier(LinearGradientBackground())
    }
}
