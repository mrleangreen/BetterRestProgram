//
//  ContentView.swift
//  BetterRest_TylerHarry
//
//  Created by Tyler Harry on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeTime
    @State private var desiredSleep = 8.0
    @State private var coffeeIntake = 1

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select your wake-up time")) {
                    DatePicker("Select a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section(header: Text("How much sleep do you need?")) {
                    Stepper(value: $desiredSleep, in: 4...12, step: 0.25) {
                        Text("\(desiredSleep, specifier: "%g") hours")
                    }
                }

                Section(header: Text("How many cups of coffee do you drink?")) {
                    Stepper(value: $coffeeIntake, in: 1...20) {
                        Text(coffeeIntake == 1 ? "1 cup" : "\(coffeeIntake) cups")
                    }
                }

                Section(header: Text("Recommended Bedtime")) {
                    Text(calculateIdealBedtime())
                        .font(.headline)
                }
            }
            .navigationBarTitle("Sleep Advisor")
        }
    }

    func calculateIdealBedtime() -> String {
        let sleepTime = 8.0 - (Double(coffeeIntake) * 0.25)
        let bedtimeHour = (wakeUpTime.get(.hour) + Int(desiredSleep) + Int(sleepTime)) % 24
        return "\(bedtimeHour):00"
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
