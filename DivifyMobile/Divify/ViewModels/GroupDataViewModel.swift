import Foundation
import Firebase
import SwiftUI

class GroupDataViewModel: ObservableObject {
    @Published var groups: [ExpenseGroup] = []
    @Published var userCache: [String: (name: String, profileImage: String)] = [:]

    private var db = Firestore.firestore()

    func fetchGroups() {
        self.groups = []
        
        guard let currentUID = Auth.auth().currentUser?.uid else {
            print("Error: Could not get current user's UID.")
            return
        }

        db.collectionGroup("members").whereField("uid", isEqualTo: currentUID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting member documents: \(error)")
                return
            }

            let dispatchGroup = DispatchGroup()
            for document in querySnapshot!.documents {
                let groupId = document.reference.parent.parent!.documentID

                dispatchGroup.enter()
                self.fetchDataForGroup(groupId: groupId, completion: {
                    dispatchGroup.leave()
                })
            }

            dispatchGroup.notify(queue: .main) {
                print("Finished all requests.")
            }
        }
    }

    private func fetchDataForGroup(groupId: String, completion: @escaping () -> Void) {
        db.collection("groups").document(groupId).getDocument { (document, error) in
            guard let document = document, let data = document.data() else {
                print("Error: No data found in the document or document does not exist")
                completion()
                return
            }
            
            let title = data["groupName"] as? String ?? ""
            let imageName = data["groupImage"] as? String ?? ""

            self.fetchGroupMembers(groupId: groupId) { members in
                self.fetchExpenses(groupId: groupId) { expenses in
                    let group = ExpenseGroup(id: groupId, image: imageName, title: title, expenses: expenses, members: members)
                    self.groups.append(group)
                    completion()
                }
            }
        }
    }


    private func fetchGroupMembers(groupId: String, completion: @escaping ([Member]) -> Void) {
        var members: [Member] = []
        
        db.collection("groups").document(groupId).collection("members").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting group members: \(error)")
            } else {
                let dispatchGroup = DispatchGroup()

                for document in querySnapshot!.documents {
                    let memberData = document.data()
                    let uid = memberData["uid"] as? String ?? ""
                    let previewName = memberData["previewName"] as? String ?? ""
                    let owedAmount = memberData["owedAmount"] as? Double ?? 0
                    let hasPaid = memberData["hasPaid"] as? Bool ?? false
                    
                    dispatchGroup.enter()
                    
                    self.fetchUserData(uid: uid) { (userData) in
                        let member = Member(profileImage: userData.profileImage, name: userData.name, previewName: previewName, owedAmount: owedAmount, hasPaid: hasPaid)
                        members.append(member)
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(members)
                }
            }
        }
    }
    
    private func fetchExpenses(groupId: String, completion: @escaping ([Expense]) -> Void) {
        var expenses: [Expense] = []

        db.collection("groups").document(groupId).collection("payments").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting group payments: \(error)")
            } else {
                let dispatchGroup = DispatchGroup()

                for document in querySnapshot!.documents {
                    let paymentData = document.data()
                    let amount = paymentData["amount"] as? Double ?? 0
                    let uid = paymentData["uid"] as? String ?? ""
                    let title = paymentData["title"] as? String ?? ""
                    let previewName = paymentData["previewName"] as? String ?? ""

                    dispatchGroup.enter()

                    self.fetchUserData(uid: uid) { (userData) in
                        let expense = Expense(title: title, amount: amount, previewName: previewName, author: userData.name)
                        expenses.append(expense)
                        dispatchGroup.leave()
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(expenses)
                }
            }
        }
    }
    
    private func fetchUserData(uid: String, completion: @escaping ((name: String, profileImage: String)) -> Void) {
        guard !uid.isEmpty else {
            print("Error: UID is empty.")
            completion((name: "", profileImage: ""))
            return
        }

        db.collection("users").document(uid).getDocument { (document, error) in
            if let error = error {
                print("Error fetching user: \(error)")
                completion((name: "", profileImage: ""))
                return
            }

            if let data = document?.data() {
                let name = data["userName"] as? String ?? ""
                let profileImage = data["profileImage"] as? String ?? ""
                completion((name: name, profileImage: profileImage))
            } else {
                completion((name: "", profileImage: ""))
            }
        }
    }

}


