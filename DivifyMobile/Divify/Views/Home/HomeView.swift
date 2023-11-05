import SwiftUI
import Firebase

struct HomeView: View {
    
    @State private var isShowingAddGroup: Bool = false
    @EnvironmentObject var groupData: GroupData
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var groupServerData = GroupDataViewModel()
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center, spacing: 8) {
                    Text("Overall, you owe")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.8))
                    
                    HStack(alignment: .center) {
                        Text("\(profileViewModel.totalAmountOwed, specifier: "US$ %.2f")")
                            .font(.largeTitle).bold()
                        
                        Text("4 XLM")
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
                
                Section("All groups") {
                    ForEach(groupServerData.groups.indices, id: \.self) { index in
                        NavigationLink {
                            GroupDetailView(group: $groupServerData.groups[index])
                        } label: {
                            GroupHomeRow(group: groupServerData.groups[index])

                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.indigo)
                    }
                }
                ToolbarItem {
                    Button {
                        isShowingAddGroup.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.indigo)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddGroup) {
                AddGroupView(groups: $groupData.groups)
            }
            .onAppear{
                groupServerData.fetchGroups()
                profileViewModel.fetchTotalAmountOwed()
                profileViewModel.fetchUsername()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
