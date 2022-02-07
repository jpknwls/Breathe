//
//  Home.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let boxRoutine = BreathingRoutine(type: .box, inhale: 4, exhale: 4, inhaleHold: 4, exhaleHold: 4)
    let pranayamaRouting = BreathingRoutine(type: .pranayama, inhale: 4, exhale: 8, inhaleHold: 7, exhaleHold: 0)

    @EnvironmentObject var settings: Settings

    var body: some View {
        TabView {
            BreathingPlayer(routine: boxRoutine)
                .tag(0)
                .tabItem {
                    // Image()
                    Image(systemName: "square")
                    Text("Box")
                }

            BreathingPlayer(routine: pranayamaRouting)
                .tag(1)
                .tabItem {
                    // Image()
                    Image(systemName: "triangle")
                    Text("Pranayama")
                }
                
            RoutineListView()
                .tag(2)
                .tabItem {
                    // Image()
                    Image(systemName: "circle")
                    Text("Custom")
                        
                }
        
            SettingsView()
                .tag(3)
                .tabItem {
                    // Image()
                    Image(systemName: "gearshape")
                    Text("Settings")
            }
        }
        .foregroundColor(settings.color)
    }
}
