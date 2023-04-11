/*
i have an app made in c++ that takes inputs and calculates square footage, paint needed, etc. I would like to convert it to a swift app but keeping the main functionality. As for inputs, I would like for there to some sort of input that allows a user to select whether or not they're doing interior, exterior, or both. Maybe something like a radio button or a selection button and when both are ticked they are doing both interior and exterior. I will leave that to you.
 
as for adding more rooms, sides, etc., there will be a "+" plus button that says "Add room" or "Add side" and let a user input the name of the item selected. They can add as many as they wish.
 
 Final output should be the same as the code I provided. Obviously we can't do the console outputs, but you can do something similar as we did with the hours calculator.

 The below code should change to the following:
 for each room, ask how many walls, then ask for required dimensions for each wall in the room. do this for each room specified by user. Then it will calculate the square footage for the room. Not the area, but the square footage.
 */

//
//  SummaryView.swift
//  Paint Calculator
//
//  Created on 2023-04-09.
//

import SwiftUI

struct ContentView: View {
    @State private var paintAreaType: Int = 0
    @State private var numberOfRooms: String = ""
    @State private var numberOfSides: String = ""
    @State private var roomDimensions: [String: (length: String, width: String, height: String, walls: String)] = [:]
    @State private var sideDimensions: [String: (length: String, width: String)] = [:]
    @State private var showSummary: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Paint Area Type")) {
                    Picker("Paint Area Type", selection: $paintAreaType) {
                        Text("Interior").tag(0)
                        Text("Exterior").tag(1)
                        Text("Both").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if paintAreaType == 0 || paintAreaType == 2 {
                    Section(header: Text("Number of Rooms")) {
                        TextField("Enter the number of rooms", text: $numberOfRooms)
                            .keyboardType(.numberPad)
                    }

                    ForEach(0..<(Int(numberOfRooms) ?? 0), id: \.self) { index in
                        Section(header: Text("Room \(index + 1) Dimensions")) {
                            TextField("Enter the length of the room", text: Binding(get: {
                                roomDimensions[String(index), default: ("", "", "", "")].length
                            }, set: { newValue in
                                roomDimensions[String(index)] = (length: newValue, width: roomDimensions[String(index), default: ("", "", "", "")].width, height: roomDimensions[String(index), default: ("", "", "", "")].height, walls: roomDimensions[String(index), default: ("", "", "", "")].walls)
                            }))
                                .keyboardType(.decimalPad)
                            
                            TextField("Enter the width of the room", text: Binding(get: {
                                roomDimensions[String(index), default: ("", "", "", "")].width
                            }, set: { newValue in
                                roomDimensions[String(index)] = (length: roomDimensions[String(index), default: ("", "", "", "")].length, width: newValue, height: roomDimensions[String(index), default: ("", "", "", "")].height, walls: roomDimensions[String(index), default: ("", "", "", "")].walls)
                            }))
                                .keyboardType(.decimalPad)
                            
                            TextField("Enter the height of the room", text: Binding(get: {
                                roomDimensions[String(index), default: ("", "", "", "")].height
                            }, set: { newValue in
                                roomDimensions[String(index)] = (length: roomDimensions[String(index), default: ("", "", "", "")].length, width: roomDimensions[String(index), default: ("", "", "", "")].width, height: newValue, walls: roomDimensions[String(index), default: ("", "", "", "")].walls)
                            }))
                                .keyboardType(.decimalPad)
                            
                            TextField("Enter the number of walls", text: Binding(get: {
                                roomDimensions[String(index), default: ("", "", "", "")].walls
                            }, set: { newValue in
                                roomDimensions[String(index)] = (length: roomDimensions[String(index), default: ("", "", "", "")].length, width: roomDimensions[String(index), default: ("", "", "", "")].width, height: roomDimensions[String(index), default: ("", "", "", "")].height, walls: newValue)
                            }))
                            .keyboardType(.numberPad)
                                                    }
                                                }
                                            }
                                            
                                            if paintAreaType == 1 || paintAreaType == 2 {
                                                Section(header: Text("Number of Exterior Sides")) {
                                                    TextField("Enter the number of exterior sides", text: $numberOfSides)
                                                        .keyboardType(.numberPad)
                                                }

                                                ForEach(0..<(Int(numberOfSides) ?? 0), id: \.self) { index in
                                                    Section(header: Text("Side \(index + 1) Dimensions")) {
                                                        TextField("Enter the length of the side", text: Binding(get: {
                                                            sideDimensions[String(index), default: ("", "")].length
                                                        }, set: { newValue in
                                                            sideDimensions[String(index)] = (length: newValue, width: sideDimensions[String(index), default: ("", "")].width)
                                                        }))
                                                            .keyboardType(.decimalPad)
                                                        
                                                        TextField("Enter the height of the side", text: Binding(get: {
                                                            sideDimensions[String(index), default: ("", "")].width
                                                        }, set: { newValue in
                                                            sideDimensions[String(index)] = (length: sideDimensions[String(index), default: ("", "")].length, width: newValue)
                                                        }))
                                                            .keyboardType(.decimalPad)
                                                    }
                                                }
                                            }

                                            Button(action: {
                                                self.showSummary = true
                                            }) {
                                                Text("Calculate")
                                                    .frame(minWidth: 0, maxWidth: .infinity)
                                            }
                                        }
                                        .navigationTitle("Paint Calculator")
                                    }
                                    .sheet(isPresented: $showSummary) {
                                        SummaryView(paintAreaType: self.$paintAreaType, numberOfRooms: self.$numberOfRooms, numberOfSides: self.$numberOfSides, roomDimensions: self.$roomDimensions, sideDimensions: self.$sideDimensions)
                                    }
                                }
                            }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
