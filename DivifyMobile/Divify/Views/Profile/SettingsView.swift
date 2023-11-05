import SwiftUI
import UIKit
import Firebase

struct SettingsView: View {
    
    var userEmail: String? {
        return Auth.auth().currentUser?.email
    }
    
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Account Info")) {
                if let email = userEmail {
                    CopyableText(text: email)
                } else {
                    Text("Not signed in")
                }
            }
            
            Section(header: Text("User ID")) {
                if let userId = uid {
                    CopyableText(text: userId)
                } else {
                    Text("Not signed in")
                }
            }
            
            Section("Log out") {
                if logStatus {
                    Button(action: {
                        try? Auth.auth().signOut()
                        logStatus = false
                    }) {
                        Label("Log Out", systemImage: "arrowshape.turn.up.left")
                            .foregroundColor(.red)
                    }
                } else {
                    Text("Came as Guest")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CopyableText: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.isUserInteractionEnabled = true
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
