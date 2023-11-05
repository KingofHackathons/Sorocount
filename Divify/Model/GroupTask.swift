import Foundation

struct GroupTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isPaid = false
    var amount: String
}
