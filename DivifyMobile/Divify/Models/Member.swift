import Foundation

struct Member: Identifiable, Hashable {
    var id = UUID()
    var profileImage: String
    var name: String
    var previewName: String
    var owedAmount: Double
    var hasPaid: Bool
}

class Members: ObservableObject {
    @Published var members: [Member] = [
        Member(profileImage: "nkoorty", name: "Artemiy", previewName: "Art", owedAmount: 512, hasPaid: false),
        Member(profileImage: "jeevan", name: "Jeevan", previewName: "Jeevan", owedAmount: 512, hasPaid: true)
    ]
}
