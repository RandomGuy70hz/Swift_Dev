//
//  SummaryView.swift
//  Paint Calculator
//
//  Created on 2023-04-09.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var paintAreaType: Int
    @Binding var numberOfRooms: String
    @Binding var numberOfSides: String
    @Binding var roomDimensions: [String: (length: String, width: String, height: String, walls: String)]
    @Binding var sideDimensions: [String: (length: String, width: String)]
    
    var body: some View {
        VStack {
            Text("Summary")
                .font(.largeTitle)
            
            List {
                if paintAreaType == 0 || paintAreaType == 2 {
                    Section(header: Text("Rooms")) {
                        ForEach(roomDimensions.keys.sorted(), id: \.self) { key in
                            let dimensions = roomDimensions[key]!
                            let length = Double(dimensions.length) ?? 0
                            let width = Double(dimensions.width) ?? 0
                            let height = Double(dimensions.height) ?? 0
                            let walls = Double(dimensions.walls) ?? 0
                            let squareFootage = (length * height * 2 + width * height * 2) * walls
                            let paintNeeded = squareFootage / 350
                            
                            VStack(alignment: .leading) {
                                Text("Room \(key)")
                                    .font(.headline)
                                Text("Square Footage: \(squareFootage, specifier: "%.2f") sq.ft")
                                Text("Paint Needed: \(paintNeeded, specifier: "%.2f") gallons")
                            }
                        }
                    }
                }
                
                if paintAreaType == 1 || paintAreaType == 2 {
                    Section(header: Text("Exterior Sides")) {
                        ForEach(sideDimensions.keys.sorted(), id: \.self) { key in
                            let dimensions = sideDimensions[key]!
                            let length = Double(dimensions.length) ?? 0
                            let width = Double(dimensions.width) ?? 0
                            let squareFootage = length * width
                            let paintNeeded = squareFootage / 350
                            
                            VStack(alignment: .leading) {
                                Text("Side \(key)")
                                    .font(.headline)
                                Text("Square Footage: \(squareFootage, specifier: "%.2f") sq.ft")
                                Text("Paint Needed: \(paintNeeded, specifier: "%.2f") gallons")
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
        .padding()
    }
}

