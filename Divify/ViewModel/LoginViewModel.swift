import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    // MARK: Firebase Login
    func loginUser(email: String = "", password: String = "") async throws {
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email: self.email, password: password != "" ? password: self.password)
        
        DispatchQueue.main.async {
            self.logStatus = true
        }
    }
}
