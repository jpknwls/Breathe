//
//  ViewModifiers.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation
import SwiftUI

struct GradientBackground: ViewModifier {
   
    let color: Color
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(colors: [color, .white],
                                    startPoint: .top,
                                    endPoint: .bottom)
                    .edgesIgnoringSafeArea([.top])
                    .background(
                          LinearGradient(colors: [.white, color],
                                    startPoint: .top,
                                    endPoint: .bottom)
                                ).opacity(0.5)
                    )
           
       }
}

extension View {
    func gradientBacking(color: Color = .gray) -> some View {
        modifier(GradientBackground( color: color))
    }
}
