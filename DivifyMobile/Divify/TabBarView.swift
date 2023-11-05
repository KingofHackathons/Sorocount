import SwiftUI

struct TabBarView: View {
    
    @StateObject var groupData = GroupData()
    @StateObject var activityData = ActivityData()

    var body: some View {
        TabView {
            HomeView()
                .environmentObject(groupData)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ActivityView()
                .environmentObject(activityData)
                .tabItem {
                    Label("Activity", systemImage: "chart.line.uptrend.xyaxis")
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
