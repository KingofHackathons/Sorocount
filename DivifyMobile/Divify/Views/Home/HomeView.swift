import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var groupData: GroupData
    
    var body: some View {
        NavigationView {
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
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.indigo)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
