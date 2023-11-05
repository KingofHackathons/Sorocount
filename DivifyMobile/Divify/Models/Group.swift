import SwiftUI
import Foundation

class ExpenseGroup: Identifiable, ObservableObject {
    var id: String = ""
    var image: String = ""
    var title: String = ""
    @Published var expenses: [Expense]
    @Published var members: [Member]
    
    var totalAmount: Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }
    
    var owedAmount: Double {
        if members.count == 0 {
            return 0
        }
        return totalAmount / Double(members.count)
    }
    
    init(id: String = UUID().uuidString, image: String = "", title: String = "", expenses: [Expense] = [], members: [Member] = []) {
        self.id = id
        self.image = image
        self.title = title
        self.expenses = expenses
        self.members = members
    }
}

class GroupData: Identifiable, ObservableObject {
    @Published var groups: [ExpenseGroup] = [
        ExpenseGroup(image: "group1", title: "London Monkeys", expenses: [
            Expense(title: "Uber ride to Oxford", amount: 12, previewName: "Huh?", author: "Desean"),
            Expense(title: "Cheeseburgers at the airport", amount: 831, previewName: "Huh?", author: "Izzy")
                    ], members: [
                        Member(profileImage: "nkoorty", name: "Artemiy", previewName: "Art", owedAmount: 512, hasPaid: false),
                        Member(profileImage: "jeevan", name: "Jeevan", previewName: "Art", owedAmount: 512, hasPaid: true)
                    ]),
        ExpenseGroup(image: "group2", title: "Mexico Monkeys", expenses: [
            Expense(title: "Uber ride to Oxford", amount: 12, previewName: "Huh?", author: "JJ"),
            Expense(title: "Cheeseburgers at the airport", amount: 831, previewName: "Huh?", author: "Monke")
                    ], members: [
                        Member(profileImage: "nkoorty", name: "Artemiy", previewName: "Art", owedAmount: 512, hasPaid: true),
                        Member(profileImage: "jeevan", name: "Jeevan", previewName: "Art", owedAmount: 512, hasPaid: false)
                    ])
    ]
    
    func delete(_ group: ExpenseGroup) {
        groups.removeAll { $0.id == group.id }
    }
    
    func add(_ group: ExpenseGroup) {
        groups.append(group)
    }
}
