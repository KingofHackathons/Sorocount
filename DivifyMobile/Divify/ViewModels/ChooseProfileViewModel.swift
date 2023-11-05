import Foundation
import Firebase
import SwiftUI

class ChooseProfileViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var error: String?
    @Published var isSuccessful = false

    func updateProfileImage(newImage: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).updateData([
            "profileImage": newImage
        ]) { err in
            if let err = err {
                self.error = "Error updating username: \(err.localizedDescription)"
            } else {
                self.isSuccessful = true
            }
        }
    }
}
