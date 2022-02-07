//
//  RoutineList.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation
import SwiftUI

struct RoutineListView: View{

    @State var adding: Bool = false
    @EnvironmentObject var settings: Settings
    
    var body: some View {
            LazyVStack {
                HStack {
                    Spacer()
                    Button(
                            action: { adding = true },
                            label: { Image(systemName: "plus") })
                                .padding()
                }
    
                ForEach(UserDefaults.standard.routines) { routine in
                    Group {
                        switch routine.type {
                            case .custom(let name):
                                Text(name)
                            default: EmptyView()
                        }
                    }
                        .padding()
                }
                Spacer()
            }
            .sheet(isPresented: $adding) {
                    AddRoutineView() { newRoutine in
                        UserDefaults.standard.routines.append(newRoutine)
                    }
                }
            
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gradientBacking(color: settings.color)
    }
}

struct AddRoutineView: View{
    @State var firstHoldActive: Bool = false
    @State var secondHoldActive: Bool = false
    @State var inhaleTime: Int = 4
    @State var inhaleHoldTime: Int = 4
    @State var exhaleTime: Int = 4
    @State var exhaleHoldTime: Int = 4
    @State var name: String = ""

    let add: (BreathingRoutine) -> ()
    
    var newRoutine: BreathingRoutine {
        return BreathingRoutine(
                    type: .custom(name.isEmpty ? "Untitled" : name),
                    inhale: inhaleTime,
                    exhale: firstHoldActive ? inhaleHoldTime : 0,
                    inhaleHold: exhaleTime,
                    exhaleHold: secondHoldActive ? exhaleHoldTime : 0
                )
    }
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Enter name here...", text: $name)
            }
            
            Section("Inhale") {
                    Stepper(value: $inhaleTime, step: 1, label: { Text("\(inhaleTime) seconds")})

            }
            Section("Hold") {
                Toggle("active", isOn: $firstHoldActive)
                    Stepper(value: $inhaleHoldTime, step: 1, label: { Text("\(inhaleHoldTime) seconds")})
                                .disabled(!firstHoldActive)
            }
            Section("Exhale") {
                Stepper(value: $exhaleTime, step: 1, label: { Text("\(exhaleTime) seconds")})

            }
            
            Section("Hold") {
                Toggle("active", isOn: $secondHoldActive)
                Stepper(value: $exhaleHoldTime, step: 1, label: { Text("\(exhaleHoldTime) seconds")})

                    .disabled(!secondHoldActive)
            }
            
            Button("Add", action: { add(newRoutine) })
        }
    }
}
