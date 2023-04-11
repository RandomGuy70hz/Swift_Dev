//
//  ContentView.swift
//  overtime_calculator
//
//  Created on 2023-04-09.
//
/*
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
}*/



import SwiftUI // Import the SwiftUI framework

struct ContentView: View { // Define the ContentView struct which conforms to the View protocol
    // Create state variables for input values
    @State private var hourlyRate: String = ""
    @State private var regularHours: String = ""
    @State private var regularOvertimeHours: String = "" // Regular overtime hours input
    @State private var holidayOvertimeHours: String = "" // Holiday overtime hours input
    @State private var workedStatHoliday: Bool = false // Statutory holiday toggle state
    @State private var regularOvertimeRate: String = "" // Regular overtime rate input
    @State private var holidayOvertimeRate: String = "" // Holiday overtime rate input
    @State private var taxRate: String = "" // Tax rate input
    
    // Add toggle for regular overtime
    @State private var regularOvertime: Bool = false // Regular overtime toggle state
    
    @State private var showSummary: Bool = false // Summary sheet presentation state
    
    // Define the user interface for ContentView
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hourly Rate")) {
                    TextField("Enter your hourly rate ($)", text: $hourlyRate)
                        .keyboardType(.decimalPad) // Use decimal keypad
                }
                
                Section(header: Text("Regular Hours")) {
                    TextField("Enter your regular worked hours", text: $regularHours)
                        .keyboardType(.decimalPad) // Use decimal keypad
                }
                
                // Regular Overtime Toggle
                Section {
                    Toggle("Overtime", isOn: $regularOvertime) // Display overtime toggle
                    
                    if regularOvertime {
                        TextField("Enter # of hours", text: $regularOvertimeHours)
                            .keyboardType(.decimalPad) // Use decimal keypad
                    }
                }
                
                Section {
                    Toggle("Statutory Holiday", isOn: $workedStatHoliday) // Display statutory holiday toggle
                    
                    if workedStatHoliday {
                        TextField("Enter number # of hours", text: $holidayOvertimeHours)
                            .keyboardType(.decimalPad) // Use decimal keypad
                    }
                }
                
                /*Section(header: Text("Overtime Rates")) {
                    if regularOvertime {
                        TextField("Enter overtime rate", text: $regularOvertimeRate)
                            .keyboardType(.decimalPad) // Use decimal keypad
                    }
                    
                    if workedStatHoliday {
                        TextField("Enter overtime rate for statutory holiday", text: $holidayOvertimeRate)
                            .keyboardType(.decimalPad) // Use decimal keypad
                    }
                }*/
                
                // Overtime Rates section with conditional visibility
                if regularOvertime || workedStatHoliday {
                    Section(header: Text("Overtime Rates")) {
                        if regularOvertime {
                            TextField("Enter overtime rate", text: $regularOvertimeRate)
                                .keyboardType(.decimalPad) // Use decimal keypad
                        }
                        
                        if workedStatHoliday {
                            TextField("Enter overtime rate for statutory holiday", text: $holidayOvertimeRate)
                                .keyboardType(.decimalPad) // Use decimal keypad
                        }
                    }
                }

                
                // User input tax
                Section(header: Text("Tax Rate")) {
                    TextField("Enter your tax rate (%)", text: $taxRate)
                        .keyboardType(.numberPad) // Use number keypad
                } // End of tax section
                
                
                // Calculate button
                Button(action: {
                    self.showSummary = true // Set showSummary to true to display summary sheet
                }) {
                    Text("Calculate")
                        .frame(minWidth: 0, maxWidth: .infinity) // Make button full width
                }
            }
            .navigationTitle("Paycheque Estimator") // Set navigation title
        }
        .sheet(isPresented: $showSummary) { // Show the summary sheet when showSummary is true
            SummaryView(hourlyRate: self.$hourlyRate, regularHours: self.$regularHours, regularOvertimeHours: self.$regularOvertimeHours, holidayOvertimeHours: self.$holidayOvertimeHours, workedStatHoliday: self.$workedStatHoliday, regularOvertimeRate: self.$regularOvertimeRate, holidayOvertimeRate: self.$holidayOvertimeRate, regularOvertime: self.$regularOvertime, taxRate: self.$taxRate)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Instantiate ContentView for preview
    }
}
