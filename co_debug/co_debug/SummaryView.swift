//
//  SummaryView.swift
//  co_debug
//
//  Created on 2023-04-09.
//

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

}


