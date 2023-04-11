//  SummaryView.swift
//  Paint Calculator
//
//  Created on 2023-04-09.
//

/*
 Summary Tab:
 
     Summary for interior:
         - give a total square footage for each room with its label.
         - total amount of paint needed for each labeled room (gallons & litres)
         
         
         - give a total square footage for all rooms together
         - give total amount of paint needed for all rooms together (in gallons & litres)
 
         ex:
         Room 1 (Living room):
                - 1,200sqFt
                - 3 Gallons or 12 litres ( 11.356 rounded to nearest whole)
         
         Room 2 (Bathroom):
                - Dimensions: 1,300sqFt
                - Paint: 3.5 Gallons or 14 litres ( 13.249 rounded up)
         Totals:
             - Dimensions: 2,500sqFt
             - Paint: 6.5 Gallons or 26 Litres
         
         etc.
         Note: Measurements are not accurate. Just a representation of how im trying to explain the summary.
         
     
    Summary for Exterior:
        - calculate square footage for each side
        - calculate total amount of paint for each side in gallons and litres
         
         - at the bottom should have a total square footage of all sides combined
         - total amount of paint needed for all sides combined in gallons and litres
 
         ex:
         Side 1 (Facing Road):
                - 1,200sqFt
                - 3 Gallons or 12 litres ( 11.356 rounded to nearest whole)
         
         Side2 (Facing Pond):
                - Dimensions: 1,300sqFt
                - Paint: 3.5 Gallons or 14 litres ( 13.249 rounded up)
         Totals:
             - Dimensions: 2,500sqFt
             - Paint: 6.5 Gallons or 26 Litres
         
         etc.
         Note: Measurements are not accurate. Just a representation of how im trying to explain the summary.
         
 
 */
/*
import SwiftUI

struct SummaryView: View {
    var interiorSummary: PaintSummary?
    var exteriorSummary: PaintSummary?
    
    var body: some View {
        VStack {
            if let interiorSummary = interiorSummary {
                Section {
                    Text("Interior Summary")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Dimensions: \(interiorSummary.squareFeet, specifier: "%.2f") sqFt")
                            Text("Paint: \(interiorSummary.gallons, specifier: "%.2f") Gallons or \(interiorSummary.litres, specifier: "%.2f") Litres")
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            
            if let exteriorSummary = exteriorSummary {
                Section {
                    Text("Exterior Summary")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Dimensions: \(exteriorSummary.squareFeet, specifier: "%.2f") sqFt")
                            Text("Paint: \(exteriorSummary.gallons, specifier: "%.2f") Gallons or \(exteriorSummary.litres, specifier: "%.2f") Litres")
                        }
                        Spacer()
                    }
                }
                .padding()
            }
            
            if let interiorSummary = interiorSummary, let exteriorSummary = exteriorSummary {
                let combinedSquareFeet = interiorSummary.squareFeet + exteriorSummary.squareFeet
                let combinedGallons = interiorSummary.gallons + exteriorSummary.gallons
                let combinedLitres = interiorSummary.litres + exteriorSummary.litres
                
                Section {
                    Text("Interior & Exterior Summary")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Dimensions: \(combinedSquareFeet, specifier: "%.2f") sqFt")
                            Text("Paint: \(combinedGallons, specifier: "%.2f") Gallons or \(combinedLitres, specifier: "%.2f") Litres")
                        }
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(
            interiorSummary: PaintSummary(squareFeet: 1200, gallons: 3, litres: 11.356),
            exteriorSummary: PaintSummary(squareFeet: 1300, gallons: 3.5, litres: 13.249)
        )
    }
}
*/
