import Foundation

struct Member: Identifiable, Hashable {
    var id = UUID()
    var profileImage: String
    var name: String
}

class Members: ObservableObject {
    @Published var members: [Member] = [
        Member(profileImage: "nkoorty", name: "Artemiy"),
        Member(profileImage: "jeevan", name: "Jeevan")
    ]
}
