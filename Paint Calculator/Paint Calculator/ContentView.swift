//  ContentView.swift
//  Paint Calculator
//
//  Created on 2023-04-09.
//

/* ------------- Simple paint calculator (IOS): ---------------
 
 User should select from three options:
     - Interior
     - Exterior
     - Interior & Exterior
     
 
 
 Interior:
 
    - Input room(s) [option to label room] (should be able to input as many rooms as they wish).
    - Add sides to each room [option to Label for each side].
    - All measurements are to be in Feet: Height, Width.
    - Repeat process for each wall, room(s) user inputs.

    - Once all room(s) are added into the program, the user should be able to calculate the square footage & paint required.
    - Summary should show square footage for EACH room (all walls dimensions combine together for specified room(s)) along with the required paint for each room then total paint needed for all rooms.
    
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
     

     
 Exterior:
 
    - Input side(s) [option to label each side] (should be able to input as many sides as they wish).
    - All measurements are to be in Feet: Height, Width.
    - Repeat process for each side(s) user inputs.

    - Once all side(s) are added into the program, the user should be able to calculate the square footage & paint for each side of the building.
    - Then below that should be the totals like shown in the example below:
 
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
     
     


 For both interior & exterior:
     - (combine the interior and exterior instructions above)
     - (by combine i dont mean to literally combine them. I just mean to have them both listed in the same view.)
     

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
         
 
        
Notes:
 
- The layout/format should be nice, clean, professional, and well formatted. It should not be jumbled together.
- Use your own discresion for which objects so use (meaning sliders, wheels, buttons, fields, etc.).
 
 
 I have two files. ContentView & SummaryView.
 These instructions should be clear. If you need more details just let me know.
 
-------------------------- */


import SwiftUI

struct Room: Identifiable {
    let id = UUID()
    var width: Double
    var length: Double
    var height: Double
}

struct Side: Identifiable {
    let id = UUID()
    var width: Double
    var height: Double
}

struct PaintSummary {
    var squareFeet: Double
    var gallons: Double
    var litres: Double
}



struct ContentView: View {
    @State private var selection = 0
    @State private var interiorWalls: [InteriorWall] = []
    @State private var showInteriorSummary = false
    @State private var interiorSummary: PaintSummary?
    @State private var exteriorWalls: [ExteriorWall] = []
    @State private var showExteriorSummary = false
    @State private var exteriorSummary: PaintSummary?
    @State private var inputFocused: Bool = false

    var body: some View {
        TabView(selection: $selection) {
            InteriorView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Interior")
                    }
                }.tag(0)
            ExteriorView()
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Exterior")
                    }
                }.tag(1)
        }
    }
}

struct InteriorView: View {
    @State private var rooms: [Room] = []
    @State private var twoCoats = false
    @State private var inputFocused: Bool = false
    @State private var showAlert = false
    @State private var showSummary = false
    @State private var interiorSummary: PaintSummary?

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                    Section {
                        ForEach(rooms) { room in
                            RoomRow(room: room, inputFocused: $inputFocused)
                        }
                        .onDelete(perform: deleteRoom)
                    }
                    Button(action: addRoom) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Room")
                        }
                    }
                }
                .padding(.bottom, inputFocused ? 200 : 0)
                .animation(.easeInOut(duration: 0.3))
                
                Button(action: {
                    if rooms.isEmpty {
                        showAlert = true
                    } else {
                        calculatePaint()
                    }
                }) {
                    Text("Calculate Paint")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please add at least one room."), dismissButton: .default(Text("OK")))
                }
                
                if showSummary {
                    if let summary = interiorSummary {
                        Text("You'll need \(summary.gallons, specifier: "%.2f") gallons (\(summary.litres, specifier: "%.2f") litres) of paint to cover \(summary.squareFeet, specifier: "%.2f") square feet.")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Interior Paint Calculator", displayMode: .inline)
        }
    }

    func addRoom() {
        rooms.append(Room(label: "", walls: []))
    }

    func deleteRoom(at offsets: IndexSet) {
        rooms.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = rooms.reduce(0.0) {
            total, room in
            total + room.walls.reduce(0.0) {
                wallTotal, wall in
                wallTotal + (wall.width * wall.height)
            }
        }
        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        interiorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }
}

struct ExteriorView: View {
    @State private var sides: [Side] = []
    @State private var twoCoats = false
    @State private var inputFocused: Bool = false
    @State private var showAlert = false
    @State private var showSummary = false
    @State private var exteriorSummary: PaintSummary?

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                    Section {
                        ForEach(sides) { side in
                            SideRow(side: side, inputFocused: $inputFocused)
                        }
                        .onDelete(perform: deleteSide)
                    }
                    Button(action: addSide) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Side")
                        }
                    }
                }
                .padding(.bottom, inputFocused ? 200 : 0)
                .animation(.easeInOut(duration: 0.3))
                
                Button(action: {
                    if sides.isEmpty {
                        showAlert = true
                    } else {
                        calculatePaint()
                    }
                }) {
                    Text("Calculate Paint")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please add at least one side."), dismissButton: .default(Text("OK")))
                }
                
                if showSummary {
                    if let summary = exteriorSummary {
                        Text("You'll need \(summary.gallons, specifier: "%.2f") gallons (\(summary.litres, specifier: "%.2f") litres) of paint to cover \(summary.squareFeet, specifier: "%.2f") square feet.")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Exterior Paint Calculator", displayMode: .inline)
        }
    }

    func addSide() {
        sides.append(Side(width: 0.0, height: 0.0))
    }

    func deleteSide(at offsets: IndexSet) {
        sides.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = sides.reduce(0.0) {
            total, side in
            total + (side.width * side.height)
        }
        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        exteriorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }
}












/*
import SwiftUI

extension View {
    func onFocusChange(_ action: @escaping (Bool) -> Void) -> some View {
        self
            .background(FocusAwareTextField(action: action))
    }
}

struct FocusAwareTextField: UIViewRepresentable {
    var action: (Bool) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusAwareTextField

        init(_ parent: FocusAwareTextField) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.action(true)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.action(false)
        }
    }
}

struct ContentView: View {
    @State private var selection = 0
    @State private var rooms: [Room] = []
    @State private var showInteriorSummary = false
    @State private var interiorSummary: PaintSummary?
    @State private var sides: [Wall] = []
    @State private var showExteriorSummary = false
    @State private var exteriorSummary: PaintSummary?
    @State private var inputFocused: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Picker("Paint Calculator", selection: $selection) {
                    Text("Interior").tag(0)
                    Text("Exterior").tag(1)
                    Text("Interior & Exterior").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if selection == 0 {
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary, inputFocused: $inputFocused)
                } else if selection == 1 {
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary, inputFocused: $inputFocused)
                } else {
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary, inputFocused: $inputFocused)
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary, inputFocused: $inputFocused)
                }
            }
            .navigationBarTitle("Paint Estimator", displayMode: .inline)
        }
    }
}

struct Room: Identifiable {
    let id = UUID()
    var label: String
    var walls: [Wall]
}

struct Wall: Identifiable {
    let id = UUID()
    var label: String
    var width: Double
    var height: Double
}

struct PaintSummary {
    let squareFeet: Double
    let gallons: Double
    let litres: Double
}



struct InteriorView: View {
    @Binding var rooms: [Room]
    @State private var twoCoats = false
    @Binding var showSummary: Bool
    @Binding var interiorSummary: PaintSummary?
    @State private var showAlert = false
    @Binding var inputFocused: Bool

    func addRoom() {
        rooms.append(Room(label: "", walls: []))
    }

    func deleteRoom(at offsets: IndexSet) {
        rooms.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = rooms.reduce(0.0) {
            total, room in
            total + room.walls.reduce(0.0) {
                wallTotal, wall in
                wallTotal + (wall.width * wall.height)
            }
        }
        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        interiorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                }
                Section {
                    ForEach(rooms) { room in
                        RoomRow(room: room, inputFocused: $inputFocused)
                    }
                    .onDelete(perform: deleteRoom)
                }
                Button(action: addRoom) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Room")
                    }
                }
            }
        }
        .padding(.bottom, inputFocused ? 200 : 0)
        .animation(.easeInOut(duration: 0.3))
        
        
        // Inside InteriorView struct
        .navigationBarItems(trailing: Button(action: {
            if rooms.isEmpty {
                showAlert = true
            } else {
                calculatePaint()
            }
        }) {
            Text("Calculate")
                .foregroundColor(.blue)
        })
                            
                            
                            
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Please add at least one room."), dismissButton: .default(Text("OK")))
        }
        
        .sheet(isPresented: $showSummary) {
            if let summary = interiorSummary {
                SummaryView(summary: summary, rooms: rooms, twoCoats: twoCoats)
            }
        }
    }
}

struct SummaryView: View {
    let summary: PaintSummary
    let rooms: [Room]
    let twoCoats: Bool
    
    init(summary: PaintSummary, rooms: [Room], twoCoats: Bool) {
        self.summary = summary
        self.rooms = rooms
        self.twoCoats = twoCoats
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(rooms) { room in
                        let roomSquareFeet = room.walls.reduce(0.0) { total, wall in
                            total + (wall.width * wall.height)
                        }
                        let roomSquareFeetToCover = twoCoats ? roomSquareFeet * 2 : roomSquareFeet
                        let roomGallons = roomSquareFeetToCover / 350
                        let roomLitres = roomGallons * 3.78541
                        VStack(alignment: .leading) {
                            Text("Total SqFt for \(room.label): \(roomSquareFeetToCover, specifier: "%.2f")")
                            Text("Total Paint need for \(room.label): \(roomGallons, specifier: "%.2f") gal (\(roomLitres, specifier: "%.2f") litres)")
                        }
                    }
                }
            }
            Section {
                Text("Total SqFt: \(summary.squareFeet, specifier: "%.2f")")
                Text("Total paint needed: \(summary.gallons, specifier: "%.2f") gal (\(summary.litres, specifier: "%.2f") litres)")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Summary", displayMode: .inline)
    }
}

struct RoomRow: View {
    @State var room: Room
    @Binding var inputFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Room Name", text: $room.label)
                .onFocusChange { focused in
                    inputFocused = focused
                }
            HStack {
                Text("Walls")
                    .font(.headline)
                Spacer()
                Button(action: {
                    room.walls.append(Wall(label: "", width: 0, height: 0)) // change
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            ForEach(room.walls) { wall in
                WallRow(wall: wall, inputFocused: $inputFocused)
            }
        }
    }
}

// Inside the WallRow struct
struct WallRow: View {
    @State var wall: Wall
    @Binding var inputFocused: Bool
    var body: some View {
        HStack {
            TextField("Wall Label", text: $wall.label)
                .onFocusChange { focused in
                    inputFocused = focused
                }
            TextField("Width", value: $wall.width, formatter: NumberFormatter())
                .onFocusChange { focused in
                    inputFocused = focused
                }
                .keyboardType(.decimalPad)
                .textContentType(.none)
            TextField("Height", value: $wall.height, formatter: NumberFormatter())
                .onFocusChange { focused in
                    inputFocused = focused
                }
                .keyboardType(.decimalPad)
                .textContentType(.none)
        }
    }
}

// Rest of the code remains the same for ExteriorView
struct ExteriorView: View {
    @Binding var sides: [Wall]
    @State private var twoCoats = false
    @Binding var showSummary: Bool
    @Binding var exteriorSummary: PaintSummary?
    @State private var showAlert = false
    @Binding var inputFocused: Bool

    func addSide() {
        sides.append(Wall(label: "", width: 0, height: 0))
    }

    func deleteSide(at offsets: IndexSet) {
        sides.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = sides.reduce(0.0) { total, side in
            total + (side.width * side.height)
        }

        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        exteriorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                }
                Section {
                    ForEach(sides) { side in
                        WallRow(wall: side, inputFocused: $inputFocused)
                    }
                    .onDelete(perform: deleteSide)
                }
                Button(action: addSide) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Side")
                    }
                }
            }
            
            
            // Inside ExteriorView struct
            Button(action: {
                if sides.isEmpty {
                    showAlert = true
                } else {
                    calculatePaint()
                }
            }) {
                Text("Calculate Paint")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please add at least one side/room."), dismissButton: .default(Text("OK")))
            }
            
            
            
            
            if showSummary {
                if let summary = exteriorSummary {
                    Text("You'll need \(summary.gallons, specifier: "%.2f") gallons (\(summary.litres, specifier: "%.2f") litres) of paint to cover \(summary.squareFeet, specifier: "%.2f") square feet.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .padding(.bottom, inputFocused ? 200 : 0)
        .animation(.easeInOut(duration: 0.3))
    }
}*/













// modifications
/*
import SwiftUI

extension View {
    func onFocusChange(_ action: @escaping (Bool) -> Void) -> some View {
        self
            .background(FocusAwareTextField(action: action))
    }
}

struct FocusAwareTextField: UIViewRepresentable {
    var action: (Bool) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusAwareTextField

        init(_ parent: FocusAwareTextField) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.action(true)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.action(false)
        }
    }
}

struct ContentView: View {
    @State private var selection = 0
    @State private var rooms: [Room] = []
    @State private var showInteriorSummary = false
    @State private var interiorSummary: PaintSummary?
    @State private var sides: [Wall] = []
    @State private var showExteriorSummary = false
    @State private var exteriorSummary: PaintSummary?
    @State private var inputFocused: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Picker("Paint Calculator", selection: $selection) {
                    Text("Interior").tag(0)
                    Text("Exterior").tag(1)
                    Text("Interior & Exterior").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if selection == 0 {
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary, inputFocused: $inputFocused)
                } else if selection == 1 {
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary, inputFocused: $inputFocused)
                } else {
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary, inputFocused: $inputFocused)
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary, inputFocused: $inputFocused)
                }
            }
            .navigationBarTitle("Paint Estimator", displayMode: .inline)
        }
    }
}

struct Room: Identifiable {
    let id = UUID()
    var label: String
    var walls: [Wall]
}

struct Wall: Identifiable {
    let id = UUID()
    var label: String
    var width: Double
    var height: Double
}

struct PaintSummary {
    let squareFeet: Double
    let gallons: Double
    let litres: Double
}



struct InteriorView: View {
    @Binding var rooms: [Room]
    @State private var twoCoats = false
    @Binding var showSummary: Bool
    @Binding var interiorSummary: PaintSummary?
    @State private var showAlert = false
    @Binding var inputFocused: Bool

    func addRoom() {
        rooms.append(Room(label: "", walls: []))
    }

    func deleteRoom(at offsets: IndexSet) {
        rooms.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = rooms.reduce(0.0) {
            total, room in
            total + room.walls.reduce(0.0) {
                wallTotal, wall in
                wallTotal + (wall.width * wall.height)
            }
        }
        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        interiorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                }
                Section {
                    ForEach(rooms) { room in
                        RoomRow(room: room, inputFocused: $inputFocused)
                    }
                    .onDelete(perform: deleteRoom)
                }
                Button(action: addRoom) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Room")
                    }
                }
            }
        }
        .padding(.bottom, inputFocused ? 200 : 0)
        .animation(.easeInOut(duration: 0.3))
        .navigationBarItems(trailing: Button(action: {
            if rooms.isEmpty {
                showAlert = true
            } else {
                calculatePaint()
            }
        }) {
            Text("Calculate")
                .foregroundColor(.blue)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Please add at least one room."), dismissButton: .default(Text("OK")))
        })
        
        .sheet(isPresented: $showSummary) {
            if let summary = interiorSummary {
                SummaryView(summary: summary, rooms: rooms, twoCoats: twoCoats)
            }
        }
    }
}

struct SummaryView: View {
    let summary: PaintSummary
    let rooms: [Room]
    let twoCoats: Bool
    
    init(summary: PaintSummary, rooms: [Room], twoCoats: Bool) {
        self.summary = summary
        self.rooms = rooms
        self.twoCoats = twoCoats
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(rooms) { room in
                        let roomSquareFeet = room.walls.reduce(0.0) { total, wall in
                            total + (wall.width * wall.height)
                        }
                        let roomSquareFeetToCover = twoCoats ? roomSquareFeet * 2 : roomSquareFeet
                        let roomGallons = roomSquareFeetToCover / 350
                        let roomLitres = roomGallons * 3.78541
                        VStack(alignment: .leading) {
                            Text("Total SqFt for \(room.label): \(roomSquareFeetToCover, specifier: "%.2f")")
                            Text("Total Paint need for \(room.label): \(roomGallons, specifier: "%.2f") gal (\(roomLitres, specifier: "%.2f") litres)")
                        }
                    }
                }
            }
            Section {
                Text("Total SqFt: \(summary.squareFeet, specifier: "%.2f")")
                Text("Total paint needed: \(summary.gallons, specifier: "%.2f") gal (\(summary.litres, specifier: "%.2f") litres)")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Summary", displayMode: .inline)
    }
}

struct RoomRow: View {
    @State var room: Room
    @Binding var inputFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Room Name", text: $room.label)
                .onFocusChange { focused in
                    inputFocused = focused
                }
            HStack {
                Text("Walls")
                    .font(.headline)
                Spacer()
                Button(action: {
                    room.walls.append(Wall(label: "", width: 0, height: 0))
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            ForEach(room.walls) { wall in
                WallRow(wall: wall, inputFocused: $inputFocused)
            }
        }
    }
}

struct WallRow: View {
    @State var wall: Wall
    @Binding var inputFocused: Bool
    var body: some View {
        HStack {
            TextField("Wall Label", text: $wall.label)
                .onFocusChange { focused in
                    inputFocused = focused
                }
            TextField("Width", value: $wall.width, formatter: NumberFormatter())
                .onFocusChange { focused in
                    inputFocused = focused
                }
                .keyboardType(.decimalPad)
            TextField("Height", value: $wall.height, formatter: NumberFormatter())
                .onFocusChange { focused in
                    inputFocused = focused
                }
                .keyboardType(.decimalPad)
        }
    }
}

// Rest of the code remains the same for ExteriorView
struct ExteriorView: View {
    @Binding var sides: [Wall]
    @State private var twoCoats = false
    @Binding var showSummary: Bool
    @Binding var exteriorSummary: PaintSummary?
    @State private var showAlert = false
    @Binding var inputFocused: Bool

    func addSide() {
        sides.append(Wall(label: "", width: 0, height: 0))
    }

    func deleteSide(at offsets: IndexSet) {
        sides.remove(atOffsets: offsets)
    }

    func calculatePaint() {
        let squareFeet = sides.reduce(0.0) { total, side in
            total + (side.width * side.height)
        }

        let squareFeetToCover = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = squareFeetToCover / 350
        let litres = gallons * 3.78541

        exteriorSummary = PaintSummary(squareFeet: squareFeetToCover, gallons: gallons, litres: litres)
        showSummary = true
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Toggle("Two coats of paint?", isOn: $twoCoats)
                }
                Section {
                    ForEach(sides) { side in
                        WallRow(wall: side, inputFocused: $inputFocused)
                    }
                    .onDelete(perform: deleteSide)
                }
                Button(action: addSide) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Side")
                    }
                }
            }
            Button(action: {
                if sides.isEmpty {
                    showAlert = true
                } else {
                    calculatePaint()
                }
            }) {
                Text("Calculate Paint")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please add at least one side."), dismissButton: .default(Text("OK")))
            }
            if showSummary {
                if let summary = exteriorSummary {
                    Text("You'll need \(summary.gallons, specifier: "%.2f") gallons (\(summary.litres, specifier: "%.2f") litres) of paint to cover \(summary.squareFeet, specifier: "%.2f") square feet.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
        .padding(.bottom, inputFocused ? 200 : 0)
        .animation(.easeInOut(duration: 0.3))
    }
}*/




// end of modifications



// -------------------------------------------------------- //
// ContentView.swift
/*import SwiftUI


struct ContentView: View {
    @State private var selection = 0
    @State private var rooms: [Room] = []
    @State private var showInteriorSummary = false
    @State private var interiorSummary: PaintSummary?
    @State private var sides: [Wall] = []
    @State private var showExteriorSummary = false
    @State private var exteriorSummary: PaintSummary?
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Paint Calculator", selection: $selection) {
                    Text("Interior").tag(0)
                    Text("Exterior").tag(1)
                    Text("Interior & Exterior").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if selection == 0 {
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary)
                } else if selection == 1 {
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary)
                } else {
                    //InteriorExteriorView()
                    InteriorView(rooms: $rooms, showSummary: $showInteriorSummary, interiorSummary: $interiorSummary)
                    ExteriorView(sides: $sides, showSummary: $showExteriorSummary, exteriorSummary: $exteriorSummary)
                }
            }
            .navigationBarTitle("Paint Estimator", displayMode: .inline)
        }
    }
}


struct Room: Identifiable {
    let id = UUID()
    var label: String
    var walls: [Wall]
}


struct Wall: Identifiable {
    let id = UUID()
    var label: String
    var width: Double
    var height: Double
}


struct PaintSummary {
    let squareFeet: Double
    let gallons: Double
    let litres: Double
}


struct InteriorView: View {
    
    @Binding var rooms: [Room]
    @Binding var showSummary: Bool
    @Binding var interiorSummary: PaintSummary?
    
    @State private var twoCoats = false
    @State private var showAlert = false
    @State private var inputFocused: Bool = false // should hide buttons
    
    func addRoom() {
        rooms.append(Room(label: "", walls: []))
    }
    
    func deleteRoom(at offsets: IndexSet) {
        rooms.remove(atOffsets: offsets)
    }
    
    func calculatePaint() {
        let squareFeet = rooms.reduce(0.0) { total, room in
            total + room.walls.reduce(0.0) { total, wall in
                total + wall.width * wall.height
            }
        }
        
        let adjustedSquareFeet = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = adjustedSquareFeet / 350
        let litres = gallons * 3.78541
        interiorSummary = PaintSummary(squareFeet: adjustedSquareFeet, gallons: gallons, litres: litres)
        showAlert = true
    }
    
    func summaryMessage() -> String {
        let totalSquareFeet = interiorSummary?.squareFeet ?? 0
        let totalGallons = interiorSummary?.gallons ?? 0
        let totalLitres = interiorSummary?.litres ?? 0
        var message = "Total Sqft: \(String(format: "%.2f", totalSquareFeet))\n"
        message += "Total paint needed: \(String(format: "%.2f", totalGallons)) gallons / \(String(format: "%.2f", totalLitres)) litres\n\n"
        for (index, room) in rooms.enumerated() {
            let squareFeet = room.walls.reduce(0.0) { total, wall in
                total + wall.width * wall.height
            }
            
            let gallons = squareFeet / 350
            let litres = gallons * 3.78541
            message += "Room \(index + 1): \(room.label)\n"
            message += "Sqft: \(String(format: "%.2f", squareFeet))\n"
            message += "Paint needed: \(String(format: "%.2f", gallons)) gallons / \(String(format: "%.2f", litres)) litres\n\n"

        }
        
        return message
    }
    var body: some View {
        VStack {
            Text("Add your rooms and walls below")
            List {
                ForEach(rooms.indices, id: \.self) { index in
                    RoomEditor(room: $rooms[index]) // fix error
                }
                
                .onDelete(perform: deleteRoom)
            }
            
            Button(action: {
                addRoom()
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Room")
                }
            }
            
            //.padding()
            Toggle("Two coats", isOn: $twoCoats)
                .padding()

            Button(action: {
                calculatePaint()
            }) {
                Text("Calculate Paint")
            }
            
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Paint Summary"), message: Text(summaryMessage()), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct RoomEditor: View {
    
    @Binding var room: Room
    @Binding var inputFocused: Bool
    
    var body: some View {
        
    VStack(alignment: .leading) {
        
    TextField("Room Label", text: $room.label)
        
    .textFieldStyle(RoundedBorderTextFieldStyle())
        
            ForEach(room.walls.indices, id: \.self) { index in
                WallEditor(wall: $room.walls[index], labelText: "Wall \(index + 1)") // fix error
            }
        
            Button(action: {
                room.walls.append(Wall(label: "", width: 0, height: 0))
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Wall")
                }
            }
        
            .padding(.bottom)
        }
        
        .padding()
    }
}


struct WallEditor: View {
    
    let labelText: String
    
    @Binding var wall: Wall
    
    @FocusState private var isWidthFocused: Bool
    @FocusState private var isHeightFocused: Bool

    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(labelText)
            
            HStack {
                
                TextField("Width", value: $wall.width, formatter: NumberFormatter())
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isWidthFocused)
                
                    .onTapGesture {
                        wall.width = 0
                        isWidthFocused = true
                    }
                
                    .onChange(of: isWidthFocused) { focused in // this should clear field
                        if focused {
                            wall.width = 0
                        }
                    }
                
                TextField("Height", value: $wall.height, formatter: NumberFormatter())
                
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isHeightFocused)
                
                    .onTapGesture {
                        wall.height = 0
                        isHeightFocused = true
                    }
                
                    .onChange(of: isHeightFocused) { focused in // this should clear field
                        if focused {
                            wall.height = 0
                        }
                    }
            }
        }
    }
}


struct ExteriorView: View {
    
    @Binding var sides: [Wall]
    @Binding var showSummary: Bool
    @Binding var exteriorSummary: PaintSummary?
    
    @State private var twoCoats = false
    @State private var showAlert = false
    @State private var inputFocused: Bool = false // should hide buttons
    
    func addSide() {
        sides.append(Wall(label: "", width: 0, height: 0))
    }
    
    func deleteSide(at offsets: IndexSet) {
        sides.remove(atOffsets: offsets)
    }
    
    func calculatePaint() {
        let squareFeet = sides.reduce(0.0) { total, side in
            total + side.width * side.height
        }
        
        let adjustedSquareFeet = twoCoats ? squareFeet * 2 : squareFeet
        let gallons = adjustedSquareFeet / 350
        let litres = gallons * 3.78541
        
        exteriorSummary = PaintSummary(squareFeet: adjustedSquareFeet, gallons: gallons, litres: litres)
        showAlert = true
    }
    
    func summaryMessage() -> String {
        
        let totalSquareFeet = exteriorSummary?.squareFeet ?? 0
        let totalGallons = exteriorSummary?.gallons ?? 0
        let totalLitres = exteriorSummary?.litres ?? 0
        
        var message = "Total Sqft: \(String(format: "%.2f", totalSquareFeet))\n"
        message += "Total paint needed: \(String(format: "%.2f", totalGallons)) gallons / \(String(format: "%.2f", totalLitres)) litres\n\n"
        
        for (index, side) in sides.enumerated() {
            
            let squareFeet = side.width * side.height
            let gallons = squareFeet / 350
            let litres = gallons * 3.78541
            
            message += "Side \(index + 1): \(side.label)\n"
            message += "Sqft: \(String(format: "%.2f", squareFeet))\n"
            message += "Paint needed: \(String(format: "%.2f", gallons)) gallons / \(String(format: "%.2f", litres)) litres\n\n"
        }
        
        return message
    }
    
    var body: some View {
        
        VStack {
            
            Toggle("Two coats", isOn: $twoCoats)
                .padding() // note
            
            Text("Add your exterior walls here")
            
            List {
                ForEach(sides.indices, id: \.self) { index in
                    WallEditor(wall: $sides[index], labelText: "Side \(index + 1)") // fix error
                }
                
                .onDelete(perform: deleteSide)
            }
            
            Button(action: {
                addSide()
            }) {
                
                HStack {
                    Image(systemName: "plus")
                    Text("Add Side")
                }
            }
            
            .padding()

            Button(action: {
                calculatePaint()
            }) {
                Text("Calculate Paint")
            }
            
            .padding()
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Paint Summary"), message: Text(summaryMessage()), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}*/
