import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(GroupData())
                .environmentObject(ActivityData())
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            GroupsView()
                .tabItem {
                    Label("Groups", systemImage: "person.2.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
