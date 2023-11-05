import Foundation
import Firebase

struct Expense: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var amount: Double
    var previewName: String
    var author: String
}

class ExpenseData: ObservableObject {
    @Published var expenses: [Expense] = [
        Expense(title: "Bananas", amount: 32, previewName: "Huh?", author: "Desean"),
        Expense(title: "Monkeys", amount: 4, previewName: "Huh?", author: "Izzy")
    ]
    
    func delete(_ expense: Expense) {
        expenses.removeAll { $0.id == expense.id }
    }
    
    func add(_ expense: Expense) {
        expenses.append(expense)
    }
}
