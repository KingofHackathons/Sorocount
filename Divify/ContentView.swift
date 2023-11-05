import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
             TabBarView()
                .preferredColorScheme(.light)
        } else {
            LoginView()
                .navigationBarHidden(true)
                .preferredColorScheme(.light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
