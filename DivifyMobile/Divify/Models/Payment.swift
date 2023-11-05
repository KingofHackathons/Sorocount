import Foundation

struct Payment: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var amount: Int
}

class PaymentData: ObservableObject {
    @Published var payments: [Payment] = [
        Payment(title: "Bananas", amount: 32),
        Payment(title: "Monkeys", amount: 4)
    ]
    
    func delete(_ payment: Payment) {
        payments.removeAll { $0.id == payment.id }
    }
    
    func add(_ payment: Payment) {
        payments.append(payment)
    }
}
