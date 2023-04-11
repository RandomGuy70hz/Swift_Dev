//
//  ContentView.swift
//  overtime_calculator
//
//  Created on 2023-04-09.
//

import SwiftUI

struct ContentView: View {

    // variables
    @State private var hourlyRate: String = ""
    @State private var regularHours: String = ""
    @State private var regularOvertimeHours: String = ""
    @State private var holidayOvertimeHours: String = ""
    @State private var workedStatHoliday: Bool = false
    @State private var regularOvertimeRate: String = ""
    @State private var holidayOvertimeRate: String = ""
    @State private var taxRate: String = "" // tax rate
    
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
                    Toggle("Overtime?", isOn: $regularOvertime)
                    
                    if regularOvertime {
                        TextField("Enter # of hours", text: $regularOvertimeHours)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    Toggle("Worked during a statutory holiday?", isOn: $workedStatHoliday)
                    
                    if workedStatHoliday {
                        TextField("Enter number # of hours", text: $holidayOvertimeHours)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Overtime Rates")) {
                    if regularOvertime {
                        TextField("Enter overtime rate", text: $regularOvertimeRate)
                            .keyboardType(.decimalPad)
                    }
                    
                    if workedStatHoliday {
                        TextField("Enter overtime rate for statutory holiday", text: $holidayOvertimeRate)
                            .keyboardType(.decimalPad)
                    }
                }
                
                // user input tax
                Section(header: Text("Tax Rate")) {
                    TextField("Enter your tax rate (%)", text: $taxRate)
                        .keyboardType(.numberPad)
                } 

                // updated code to center button
                Button(action: {
                    self.showSummary = true
                }) {
                    Text("Calculate")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }

            // main title
            .navigationTitle("Paycheque Calculator")
        }
        
        // tax sheet
        .sheet(isPresented: $showSummary) {
            SummaryView(hourlyRate: self.$hourlyRate, regularHours: self.$regularHours, regularOvertimeHours: self.$regularOvertimeHours, holidayOvertimeHours: self.$holidayOvertimeHours, workedStatHoliday: self.$workedStatHoliday, regularOvertimeRate: self.$regularOvertimeRate, holidayOvertimeRate: self.$holidayOvertimeRate, regularOvertime: self.$regularOvertime, taxRate: self.$taxRate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
