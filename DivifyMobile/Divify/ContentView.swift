import SwiftUI

struct ContentView: View {
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var groupServerData = GroupDataViewModel()
    
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
             TabBarView()
                .preferredColorScheme(.light)
                .onAppear {
                    profileViewModel.fetchUsername()
                    profileViewModel.fetchProfileImage()
                    profileViewModel.fetchPublicKey()
                    profileViewModel.fetchSecretSeed()
                    profileViewModel.fetchTotalAmountOwed()
                    groupServerData.fetchGroups()
                }
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
