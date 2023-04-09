//
//  ContentView.swift
//  overtime_calculator
//
//  Created on 2023-04-09.
//

import SwiftUI

struct ContentView: View {
    @State private var hourlyRate: String = ""
    @State private var regularHours: String = ""
    @State private var regularOvertimeHours: String = ""
    @State private var holidayOvertimeHours: String = ""
    @State private var workedStatHoliday: Bool = false
    @State private var regularOvertimeRate: String = ""
    @State private var holidayOvertimeRate: String = ""
    
    // Add toggle for regular overtime
    @State private var regularOvertime: Bool = false
    
    @State private var showSummary: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hourly Rate")) {
                    TextField("Enter your hourly rate ($)", text: $hourlyRate)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Regular Hours")) {
                    TextField("Enter your regular worked hours", text: $regularHours)
                        .keyboardType(.decimalPad)
                }
                
                // Regular Overtime Toggle
                Section {
                    Toggle("Regular Overtime?", isOn: $regularOvertime)
                    
                    if regularOvertime {
                        TextField("Enter amount of hours worked in regular overtime", text: $regularOvertimeHours)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    Toggle("Worked during a statutory holiday?", isOn: $workedStatHoliday)
                    
                    if workedStatHoliday {
                        TextField("Enter number of hours you worked on the statutory holiday", text: $holidayOvertimeHours)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Overtime Rates")) {
                    if regularOvertime {
                        TextField("Enter overtime rate for regular overtime", text: $regularOvertimeRate)
                            .keyboardType(.decimalPad)
                    }
                    
                    if workedStatHoliday {
                        TextField("Enter overtime rate for statutory holiday", text: $holidayOvertimeRate)
                            .keyboardType(.decimalPad)
                    }
                }
                
                // updated code to center button
                Button(action: {
                    self.showSummary = true
                }) {
                    Text("Calculate")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                // end of update to center button
                // original code:
                /*Button(action: {
                    self.showSummary = true
                }) {
                    Text("Calculate")
                }*/
            }
            .navigationTitle("Hours Calculator")
        }
        .sheet(isPresented: $showSummary) {
            SummaryView(hourlyRate: self.$hourlyRate, regularHours: self.$regularHours, regularOvertimeHours: self.$regularOvertimeHours, holidayOvertimeHours: self.$holidayOvertimeHours, workedStatHoliday: self.$workedStatHoliday, regularOvertimeRate: self.$regularOvertimeRate, holidayOvertimeRate: self.$holidayOvertimeRate, regularOvertime: self.$regularOvertime)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
