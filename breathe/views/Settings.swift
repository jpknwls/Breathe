//
//  Settings.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    var body: some View {
        VStack {
          
            ColorPicker("Color", selection: $settings.color)
                .padding()
                .background(
            RoundedRectangle(cornerRadius: 15.0)
                .foregroundColor(settings.color)
                .opacity(0.3))
                .padding()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .gradientBacking(color: settings.color)
    }
}
