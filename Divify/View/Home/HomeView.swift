import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var groupData: GroupData
    @EnvironmentObject var activityData: ActivityData
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    VStack(alignment: .center, spacing: 8) {
                        Text("Overall, you owe")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.8))
                        
                        HStack(alignment: .center) {
                            Text("119 XLM")
                                .font(.largeTitle).bold()
                            
                            Text("US$ 12.12")
                                .font(.headline).bold()
                        }
                        
                    }
                    .hCenter()
                    .listRowBackground(Color.clear)
                    
                    Section("Your groups") {
                        ForEach(groupData.groups.indices, id: \.self) { index in
                            NavigationLink {
                                GroupDetailView(group: $groupData.groups[index])
                            } label: {
                                GroupHomeRow(group: groupData.groups[index])
                            }
                        }
                    }
                    
                    Section("Activity") {
                        ForEach(activityData.activities) { activity in
                            NavigationLink {
                                
                            } label: {
                                ActivityRow(activity: activity)
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.indigo)
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
