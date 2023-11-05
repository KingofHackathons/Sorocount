import SwiftUI
import Firebase

class SignupViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    private let db = Firestore.firestore()
    
    // MARK: Firebase Signup
    func signUp() async throws {
        do {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: self.email, password: self.password)
                
                try await db.collection("users").document(authResult.user.uid).setData(["email": self.email,
                                                                                        "userName": "Username",
                                                                                        "profileImage": "monkey",
                                                                                        "publicKey": "",
                                                                                        "secretSeed": "",
                                                                                        "totalAmountOwed": 0])
                
                DispatchQueue.main.async {
                    self.logStatus = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.showError = true
                    self.errorMsg = error.localizedDescription
                }
                throw error
            }
        }
    }
}
