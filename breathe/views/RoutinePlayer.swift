//
//  RoutinePlayer.swift
//  breathe
//
//  Created by John Knowles on 2/7/22.
//

import Foundation
import SwiftUI

struct BreathingPlayer: View {
    let routine: BreathingRoutine
    
    @ObservedObject var conductor: BreathingConductor
    @State var timer: Timer? = nil
    @State var currentSecond: Int = 0
    
    var title: String {
        switch routine.type {
            case .box: return "Box Breathing"
            case .pranayama: return "Pranayama Breathing"
            case .custom(let s): return s
        }
    }
    
    
    init(routine: BreathingRoutine) {
        var components: [BreathingState] {
            var temp: [BreathingState] = []
            temp.append(.inhale(routine.inhale))
            if routine.inhaleHold > 0 {
                temp.append(.inhaleHold(routine.inhaleHold))
            }
            temp.append(.exhale(routine.exhale))
            if routine.exhaleHold > 0 {
                temp.append(.exhaleHold(routine.exhaleHold))
            }
            return temp
        }
        
        self.routine = routine
        self.conductor = BreathingConductor(states: components)
    }
    
     var currentSize: Double {
        if timer == nil { return 350 }

        switch conductor.state {
            case .inhale(_): return 60
            case .inhaleHold(_): return 60
            case .exhale(_): return 350
            case .exhaleHold(_): return 350
        }
     }
     
     var currentTiming: Int {
        
        switch conductor.state {
            case .inhale(let time): return time
            case .inhaleHold(let time): return time
            case .exhale(let time): return time
            case .exhaleHold(let time): return time
        }
     }
     
     var currentState: String {
        switch conductor.state {
            case .inhale(_): return "Inhale"
            case .inhaleHold(_): return "Hold"
            case .exhale(_): return "Exhale"
            case .exhaleHold(_): return "Hold"
        }
     }


    @EnvironmentObject var settings: Settings
    let uiScreen = UIScreen.main.bounds

    var body: some View {
        
        ZStack {
            
            VStack {
                
                if timer != nil {
                    ZStack {
                        Text(timer == nil ? "" : conductor.nextState)
                                .font(.system(size: 30, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .offset(y: 45)
                                .padding()
                                .transition(.move(edge: .top))
                                        
                        Text(timer == nil ? "" : currentState)
                            .font(.system(size: 70, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
                            
                    }
                    .padding([.bottom], 10)
                    .background(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundColor(settings.color)
                                    .opacity(0.2))
                    .padding()
                    .shadow(radius: 10.0)
                    .animation(.linear(duration: 0.3))
                    .transition(.move(edge: .top))
                }
                Spacer()
            
                Button(action: {
                     if let t = timer {
                        // timer is active
                        t.invalidate()
                        timer = nil
                        //  TODO: reset the state??
                     } else {
                        // timer is inactive
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ currentTimer in
                            // tick current second up
                            self.currentSecond += 1
                            // if we are at bound, next
                            if self.currentSecond >= Int(currentTiming) {
                                conductor.updateState()
                                self.currentSecond = 0
                                // haptic buzz
                                let feedback = UIImpactFeedbackGenerator(style: .light)
                                feedback.impactOccurred()
                            }
                        }
                    }
                }, label: {
                    Text(timer == nil ? "Start" : "Stop")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .foregroundColor(settings.color)
                                .opacity(0.5))
                })
                .shadow(radius: 15.0)
                .padding()
            
            }
        
            ZStack {
              
              
                Circle()
                    .fill(settings.color)
                    .frame(width: currentSize, height: currentSize)
                    .opacity(timer == nil ? 0.8 : 0.3)
                    .animation(.easeInOut(duration: Double(currentTiming)))
                    .shadow(radius: 5.0)
                    
                Circle()
                    .fill(settings.color)
                    .frame(width: currentSize * 0.9, height: currentSize * 0.9)
                    .opacity(timer == nil ? 0.7 : 0.4)
                    .animation(.easeInOut(duration: Double(currentTiming)))

                Circle()
                    .fill(settings.color)
                    .frame(width: currentSize * 0.75, height: currentSize * 0.75)
                    .opacity(timer == nil ? 0.4 : 0.5)
                    .animation(.easeInOut(duration: Double(currentTiming)))
              
                Circle()
                    .fill(settings.color)
                    .frame(width: currentSize * 0.6, height: currentSize * 0.6)
                    .opacity(timer == nil ? 0.2 : 0.9)
                    .animation(.easeInOut(duration: Double(currentTiming)))
              
                Text(String(currentSecond + 1))
                    .font(.largeTitle)
                    .foregroundColor(.white)
        
            }
             

        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
        .frame(maxWidth: .infinity)
        .gradientBacking(color: settings.color)
           
    }
}
