import SwiftUI
import Firebase

@main
struct DivifyApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
