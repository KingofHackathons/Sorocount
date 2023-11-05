import Foundation
import Firebase
import SwiftUI

class WalletViewModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var error: String?
    @Published var isSuccessful = false

    func updatePublicKey(newKey: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).updateData([
            "publicKey": newKey
        ]) { err in
            if let err = err {
                self.error = "Error updating public key: \(err.localizedDescription)"
            } else {
                self.isSuccessful = true
            }
        }
    }
    
    func updateSecretSeed(newSeed: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).updateData([
            "secretSeed": newSeed
        ]) { err in
            if let err = err {
                self.error = "Error updating secret seed: \(err.localizedDescription)"
            } else {
                self.isSuccessful = true
            }
        }
    }
}

