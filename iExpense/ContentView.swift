import SwiftUI
import Observation

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Personal Account")
                    .font(.headline)
                List {
                    ForEach(expenses.personalExpense) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .expenseStyle(for: item)
                        }
                    }
                    .onDelete(perform: removePersonalItem)
                }
                Text("Bussines Account")
                    .font(.headline)
                List {
                    ForEach(expenses.bussinesExpense) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .expenseStyle(for: item)
                        }
                    }
                    .onDelete(perform: removeBusinessItem)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalItem(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == expenses.personalExpense[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
    func removeBusinessItem(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: { $0.id == expenses.bussinesExpense[offset].id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
}
