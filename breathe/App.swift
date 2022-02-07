//
//  breatheApp.swift
//  breathe
//
//  Created by John Knowles on 1/28/22.
//

import SwiftUI



@main
struct BreatheApp: App {
    @StateObject var settings = Settings()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(settings)
        }
    }
}
