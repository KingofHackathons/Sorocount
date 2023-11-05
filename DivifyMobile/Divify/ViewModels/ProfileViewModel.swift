import Foundation
import Firebase
import SwiftUI

class ProfileViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    @Published var userName: String = ""
    @Published var profileImage: String = ""
    @Published var totalAmountOwed: Double = 0
    @Published var publicKey: String = ""
    @Published var secretSeed: String = ""
    @Published var error: String?
    
    func fetchUsername() {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }

        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists, let data = document.data() {
                self.userName = data["userName"] as? String ?? "Default Username"
            } else {
                self.error = "Document does not exist or error fetching."
            }
        }
    }
    
    func fetchProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists, let data = document.data() {
                self.profileImage = data["profileImage"] as? String ?? "Default Profile Image"
            } else {
                self.error = "Document does not exist or error fetching."
            }
        }
    }
    
    func fetchTotalAmountOwed() {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists, let data = document.data() {
                self.totalAmountOwed = data["totalAmountOwed"] as? Double ?? 0
            } else {
                self.error = "Document does not exist or error fetching."
            }
        }
    }
    
    func fetchPublicKey() {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists, let data = document.data() {
                self.publicKey = data["publicKey"] as? String ?? "Default Public Key"
            } else {
                self.error = "Document does not exist or error fetching."
            }
        }
    }
    
    func fetchSecretSeed() {
        guard let uid = Auth.auth().currentUser?.uid else {
            error = "No authenticated user found."
            return
        }
        
        db.collection("users").document(uid).getDocument { (document, err) in
            if let document = document, document.exists, let data = document.data() {
                self.secretSeed = data["secretSeed"] as? String ?? "Default Secret Seed"
            } else {
                self.error = "Document does not exist or error fetching."
            }
        }
    }
}

