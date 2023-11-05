import SwiftUI
import Foundation

class ExpenseGroup: Identifiable, ObservableObject {
    var id = UUID()
    var image: String = ""
    var title: String = ""
    @Published var payments: [Payment]
    @Published var members: [Member]
    
    var totalAmount: Int {
        return payments.reduce(0) { $0 + $1.amount }
    }
    
    var owedAmount: Int {
        return totalAmount / 3
    }
    
    init(image: String = "",
         title: String = "",
         payments: [Payment] = [Payment(title: "", amount: 0)],
         members: [Member] = [Member(profileImage: "", name: "")]) {
        self.image = image
        self.title = title
        self.payments = payments
        self.members = members
    }
}

class GroupData: Identifiable, ObservableObject {
    @Published var groups: [ExpenseGroup] = [
        ExpenseGroup(image: "andrew", title: "London Monkeys", payments: [
                        Payment(title: "Uber ride to Oxford", amount: 12),
                        Payment(title: "Cheeseburgers at the airport", amount: 831)
                    ], members: [
                        Member(profileImage: "nkoorty", name: "Artemiy"),
                        Member(profileImage: "jeevan", name: "Jeevan")
                    ]),
        ExpenseGroup(image: "rishi", title: "Mexico Monkeys", payments: [
                        Payment(title: "Uber ride to Oxford", amount: 12),
                        Payment(title: "Cheeseburgers at the airport", amount: 831)
                    ], members: [
                        Member(profileImage: "nkoorty", name: "Artemiy"),
                        Member(profileImage: "jeevan", name: "Jeevan")
                    ])
    ]
    
    func delete(_ group: ExpenseGroup) {
        groups.removeAll { $0.id == group.id }
    }
    
    func add(_ group: ExpenseGroup) {
        groups.append(group)
    }
}
