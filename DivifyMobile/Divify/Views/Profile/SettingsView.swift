import SwiftUI
import Firebase

struct SettingsView: View {
    
    var userEmail: String? {
        return Auth.auth().currentUser?.email
    }
    
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Account Info")) {
                if let email = userEmail {
                    Text(email)
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
