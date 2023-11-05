import Foundation
import SwiftUI

enum ActivityActions {
    case created, paid, left
}

struct Activity: Identifiable, Hashable {
    var id = UUID()
    var userName: String
    var userProfileImage: String
    var action: ActivityActions
    var group: String
    var paymentAmount: Int
    var expenseName: String?
    var date: String
}

class ActivityData: ObservableObject {
    @Published var activities: [Activity] = [
        Activity(userName: "Jeevan", userProfileImage: "jeevan", action: ActivityActions.created, group: "Monkeys", paymentAmount: 0, date: "9.9.2023"),
        Activity(userName: "Adesh", userProfileImage: "monkey", action: ActivityActions.paid, group: "Idiots", paymentAmount: 12, date: "8.9.2023"),
        Activity(userName: "Artemiy", userProfileImage: "nkoorty", action: ActivityActions.left, group: "Morons", paymentAmount: 0, date: "6.9.2023"),
    ]
    
    func add(_ activity: Activity) {
        activities.append(activity)
    }
}

