import Foundation
import SwiftUI

enum ActivityActions {
    case created, paid, left
}

class Activity: Identifiable, ObservableObject {
    var id = UUID()
    var userName: String
    var userProfileImage: String
    var action: ActivityActions
    var group: String
    var paymentAmount: Int
    var expenseName: String?
    var date: String
    
    init(id: UUID = UUID(), userName: String, userProfileImage: String, action: ActivityActions, group: String, paymentAmount: Int, expenseName: String? = nil, date: String) {
        self.id = id
        self.userName = userName
        self.userProfileImage = userProfileImage
        self.action = action
        self.group = group
        self.paymentAmount = paymentAmount
        self.expenseName = expenseName
        self.date = date
    }
}

class ActivityData: ObservableObject {
    @Published var activities: [Activity] = [
        Activity(userName: "Jeevan", userProfileImage: "lion", action: ActivityActions.created, group: "Monkeys", paymentAmount: 0, date: "9.9.2023"),
        Activity(userName: "Adesh", userProfileImage: "monkey", action: ActivityActions.paid, group: "Idiots", paymentAmount: 12, date: "8.9.2023"),
        Activity(userName: "Artemiy", userProfileImage: "dog", action: ActivityActions.left, group: "Morons", paymentAmount: 0, date: "6.9.2023"),
    ]
    
    func add(_ activity: Activity) {
        activities.append(activity)
    }
}

