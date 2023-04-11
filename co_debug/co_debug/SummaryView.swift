//
//  SummaryView.swift
//  co_debug
//
//  Created on 2023-04-09.
//
/*
import SwiftUI

struct SummaryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var hourlyRate: String
    @Binding var regularHours: String
    @Binding var regularOvertimeHours: String
    @Binding var holidayOvertimeHours: String
    @Binding var workedStatHoliday: Bool
    @Binding var regularOvertimeRate: String
    @Binding var holidayOvertimeRate: String
    @Binding var regularOvertime: Bool
    @Binding var taxRate: String // tax rate
    @State private var showSummary: Bool = false

    // Add a clear button to clear all fields
    func clearFields() {
        hourlyRate = ""
        regularHours = ""
        regularOvertimeHours = ""
        holidayOvertimeHours = ""
        workedStatHoliday = false
        regularOvertimeRate = ""
        holidayOvertimeRate = ""
        taxRate = "" // clears tax field
    }
    
    var totalHours: Double {
        let regHours = Double(regularHours) ?? 0
        let regOvertimeHours = Double(regularOvertimeHours) ?? 0
        let regOvertimeRate = Double(regularOvertimeRate) ?? 0
        let holOvertimeHours = Double(holidayOvertimeHours) ?? 0
        let holOvertimeRate = Double(holidayOvertimeRate) ?? 0
        
        return regHours + (regOvertimeHours * regOvertimeRate) + (holOvertimeHours * holOvertimeRate)
    }
    
    var grossPay: Double {
        let rate = Double(hourlyRate) ?? 0
        let regHours = Double(regularHours) ?? 0
        let regOvertimeHours = Double(regularOvertimeHours) ?? 0
        let regOvertimeRate = Double(regularOvertimeRate) ?? 0
        let holOvertimeHours = Double(holidayOvertimeHours) ?? 0
        let holOvertimeRate = Double(holidayOvertimeRate) ?? 0
        
        return (rate * regHours) +
            (rate * regOvertimeHours * regOvertimeRate) +
            (rate * holOvertimeHours * holOvertimeRate)
    }

    // Add a calculate estimated tax for 25% to add net pay to summary view
    // new tax variable
    var estimatedTax: Double {
        let rate = Double(taxRate) ?? 0
        return grossPay * (rate / 100)
    }
    
    var netPay: Double {
        return grossPay - estimatedTax
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Summary") // Change “Hours summary” to “Summary”
                    .font(.largeTitle)
                    .padding()
                
                Text("Hourly rate: $\(hourlyRate)")
                Text("Total regular hours: \(regularHours) hr(s)")
                if regularOvertime {
                    Text("Total regular overtime hours: \(regularOvertimeHours) hr(s)")
                }
                if workedStatHoliday {
                    Text("Total holiday overtime hours: \(holidayOvertimeHours) hr(s)")
                }
                Text("Total hours: \(totalHours, specifier: "%.2f") hr(s)")
                Text("Expected gross pay: $\(grossPay, specifier: "%.2f")")
                Text("Estimated tax: $\(estimatedTax, specifier: "%.2f")")
                Text("Net pay: $\(netPay, specifier: "%.2f")")

                // Add a clear button to clear all fields
                Button("Clear") {
                    clearFields()
                    showSummary = false
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            .padding()
        }
        
        //Add the new "Done" button below the "Clear" button
       Button("Done") {
           presentationMode.wrappedValue.dismiss()
       }
       .padding() // end of new "Done" button
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(hourlyRate: .constant("25"), regularHours: .constant("40"), regularOvertimeHours: .constant("5"), holidayOvertimeHours: .constant("0"), workedStatHoliday: .constant(false), regularOvertimeRate: .constant("1.5"), holidayOvertimeRate: .constant("2"), regularOvertime: .constant(true), taxRate: .constant("25"))
    }

}*/

import SwiftUI // Import the SwiftUI framework

struct SummaryView: View { // Define the SummaryView struct which conforms to the View protocol
    @Environment(\.presentationMode) var presentationMode // Access presentation mode to dismiss the view
    
    // Bindings for each input value from ContentView
    @Binding var hourlyRate: String // User input for hourly rate
    @Binding var regularHours: String // User input for regular hours
    @Binding var regularOvertimeHours: String // User input for regular overtime hours
    @Binding var holidayOvertimeHours: String // User input for holiday overtime hours
    @Binding var workedStatHoliday: Bool // User input for whether a stat holiday was worked
    @Binding var regularOvertimeRate: String // User input for regular overtime rate
    @Binding var holidayOvertimeRate: String // User input for holiday overtime rate
    @Binding var regularOvertime: Bool // User input for whether regular overtime was worked
    @Binding var taxRate: String // User input for tax rate
    @State private var showSummary: Bool = false // State variable to control showing summary

    // Function to clear all input fields
    func clearFields() {
        hourlyRate = "" // Clear hourly rate field
        regularHours = "" // Clear regular hours field
        regularOvertimeHours = "" // Clear regular overtime hours field
        holidayOvertimeHours = "" // Clear holiday overtime hours field
        workedStatHoliday = false // Reset workedStatHoliday to false
        regularOvertimeRate = "" // Clear regular overtime rate field
        holidayOvertimeRate = "" // Clear holiday overtime rate field
        taxRate = "" // Clear tax rate field
    }
    
    // Calculate total hours worked, including regular, regular overtime, and holiday overtime
    var totalHours: Double {
        let regHours = Double(regularHours) ?? 0 // Convert regularHours to Double or default to 0
        let regOvertimeHours = Double(regularOvertimeHours) ?? 0 // Convert regularOvertimeHours to Double or default to 0
        let regOvertimeRate = Double(regularOvertimeRate) ?? 0 // Convert regularOvertimeRate to Double or default to 0
        let holOvertimeHours = Double(holidayOvertimeHours) ?? 0 // Convert holidayOvertimeHours to Double or default to 0
        let holOvertimeRate = Double(holidayOvertimeRate) ?? 0 // Convert holidayOvertimeRate to Double or default to 0
        
        // Calculate total hours by adding regular hours, regular overtime, and holiday overtime
        return regHours + (regOvertimeHours * regOvertimeRate) + (holOvertimeHours * holOvertimeRate)
    }
    
    // Calculate gross pay based on hours worked and rates
    var grossPay: Double {
        let rate = Double(hourlyRate) ?? 0 // Convert hourlyRate to Double or default to 0
        let regHours = Double(regularHours) ?? 0 // Convert regularHours to Double or default to 0
        let regOvertimeHours = Double(regularOvertimeHours) ?? 0 // Convert regularOvertimeHours to Double or default to 0
        let regOvertimeRate = Double(regularOvertimeRate) ?? 0 // Convert regularOvertimeRate to Double or default to 0
        let holOvertimeHours = Double(holidayOvertimeHours) ?? 0 // Convert holidayOvertimeHours to Double or default to 0
        let holOvertimeRate = Double(holidayOvertimeRate) ?? 0 // Convert holidayOvertimeRate to Double or default to 0
        
        // Calculate gross pay by adding regular pay, regular overtime pay, and holiday overtime pay
        return (rate * regHours) +
            (rate * regOvertimeHours * regOvertimeRate) +
            (rate * holOvertimeHours * holOvertimeRate)
    }

    // Calculate the estimated tax based on the tax rate and gross pay
    var estimatedTax: Double {
        let rate = Double(taxRate) ?? 0 // Convert taxRate to Double or default to 0
        return grossPay * (rate / 100) // Calculate tax by multiplying gross pay by tax rate percentage
    }
    
    // Calculate net pay by subtracting estimated tax from gross pay
    var netPay: Double {
        return grossPay - estimatedTax
    }
    
    // Define the user interface for SummaryView
    var body: some View {
        NavigationView {
            VStack {
                Text("Summary") // Display "Summary" title
                    .font(.largeTitle)
                    .padding()
                
                Text("Hourly rate: $\(hourlyRate)") // Display hourly rate
                Text("Total regular hours: \(regularHours) hr(s)") // Display total regular hours
                if regularOvertime {
                    Text("Total regular overtime hours: \(regularOvertimeHours) hr(s)") // Display total regular overtime hours
                }
                if workedStatHoliday {
                    Text("Total holiday overtime hours: \(holidayOvertimeHours) hr(s)") // Display total holiday overtime hours
                }
                Text("Total hours: \(totalHours, specifier: "%.2f") hr(s)") // Display total hours
                Text("Expected gross pay: $\(grossPay, specifier: "%.2f")") // Display gross pay
                Text("Estimated tax: $\(estimatedTax, specifier: "%.2f")") // Display estimated tax
                Text("Net pay: $\(netPay, specifier: "%.2f")") // Display net pay

                // Add a clear button to clear all fields
                Button("Clear") {
                    clearFields() // Call the clearFields function
                    showSummary = false // Hide the summary
                    presentationMode.wrappedValue.dismiss() // Dismiss the view
                }
                .padding()
            }
            .padding()
        }
        
        // Add a "Done" button to close the view
        Button("Done") {
            presentationMode.wrappedValue.dismiss() // Dismiss the view
        }
        .padding() // Add padding to the "Done" button
    }
}

// Define the preview for SummaryView
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(hourlyRate: .constant("25"), regularHours: .constant("40"), regularOvertimeHours: .constant("5"), holidayOvertimeHours: .constant("0"), workedStatHoliday: .constant(false), regularOvertimeRate: .constant("1.5"), holidayOvertimeRate: .constant("2"), regularOvertime: .constant(true), taxRate: .constant("25"))
    }
}




