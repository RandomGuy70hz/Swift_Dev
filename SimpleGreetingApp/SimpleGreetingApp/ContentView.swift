import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var showGreeting = false
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                showGreeting.toggle()
            }) {
                Text("Greet me!")
            }
            
            if showGreeting && !name.isEmpty {
                Text("Hello, \(name)!")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
