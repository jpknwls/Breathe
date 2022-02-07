//
//  Breathing.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation

enum BreathingType: Codable {
    case box
    case pranayama
    case custom(String)
}

enum BreathingState {
    case inhale(Int)
    case inhaleHold(Int)
    case exhale(Int)
    case exhaleHold(Int)
}

struct BreathingRoutine: Codable, Identifiable {
    let id: UUID = UUID()
    var type: BreathingType
    var inhale: Int
    var exhale: Int
    var inhaleHold: Int
    var exhaleHold: Int
}

class BreathingConductor: ObservableObject {
    @Published var state: BreathingState
    var stateIndex: Int = 0
    let states: [BreathingState]
   
    init(states: [BreathingState]) {
        self.states = states
        guard !states.isEmpty else { self.state = .inhale(0); return }
        self.state = states[0]
    }
    
    var nextState: String {
        var index = stateIndex + 1
        if index == states.count {  //we were previously pointing at the end
            index = 0
        }
        switch states[index] {
            case .inhale(_): return "Inhale"
            case .inhaleHold(_): return "Hold"
            case .exhale(_): return "Exhale"
            case .exhaleHold(_): return "Hold"
        }
    }
    
    
    func updateState() {
        stateIndex += 1
        if stateIndex >= states.count {
            stateIndex = 0
        }
        // publish update back to view
        state = states[stateIndex]
    }
}
