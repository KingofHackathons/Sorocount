import Foundation
import Firebase
import SwiftUI

class DetailViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var error: String?
    @Published var isSuccessful = false

    func updateUsername(newName: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).updateData([
            "userName": newName
        ]) { err in
            if let err = err {
                self.error = "Error updating username: \(err.localizedDescription)"
            } else {
                self.isSuccessful = true
            }
        }
    }
}
