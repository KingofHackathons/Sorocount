import SwiftUI
import Foundation

struct ExpenseGroup: Identifiable, Hashable {
    var id = UUID()
    var image: String = ""
    var title: String = ""
    var payments = [Payment(title: "", amount: 0)]
    var paymentCount: Int = 0
    var members = [Member(profileImage: "", name: "")]
    var memberCount: Int = 0
    
    static var example = ExpenseGroup(
        image: "andrew",
        title: "London Monkeys",
        payments: [
            Payment(title: "Uber ride to Oxford", amount: 12),
            Payment(title: "Cheeseburgers at the airport", amount: 831)
        ],
        paymentCount: 3,
        members: [
            Member(profileImage: "nkoorty", name: "Artemiy"),
            Member(profileImage: "jeevan", name: "Jeevan")],
        memberCount: 2)
}

class GroupData: ObservableObject {
    @Published var groups: [ExpenseGroup] = [
        ExpenseGroup(image: "andrew", title: "London Monkeys", payments: [
                        Payment(title: "Uber ride to Oxford", amount: 12),
                        Payment(title: "Cheeseburgers at the airport", amount: 831)
                        ], paymentCount: 3, members: [
                        Member(profileImage: "nkoorty", name: "Artemiy"),
                        Member(profileImage: "jeevan", name: "Jeevan")], memberCount: 2),
        ExpenseGroup(image: "rishi", title: "Mexico Monkeys", payments: [
                        Payment(title: "Uber ride to Oxford", amount: 12),
                        Payment(title: "Cheeseburgers at the airport", amount: 831)
                        ], paymentCount: 1, members: [
                        Member(profileImage: "nkoorty", name: "Artemiy"),
                        Member(profileImage: "jeevan", name: "Jeevan")], memberCount: 4),
    ]
    
    func delete(_ group: ExpenseGroup) {
        groups.removeAll { $0.id == group.id }
    }
    
    func add(_ group: ExpenseGroup) {
        groups.append(group)
    }
}
