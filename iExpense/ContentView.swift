import SwiftUI
import Observation

struct ContentView: View {
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Spacer()
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "Tap")
                }
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView(name: "@twostraws")
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Second View")
        Text("Hello, \(name)!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    ContentView()
}
