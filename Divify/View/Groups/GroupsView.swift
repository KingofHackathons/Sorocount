import SwiftUI
import Firebase

struct GroupsView: View {
    
    @State private var names: [String] = []
    @State private var isLoading: Bool = false
    
    @State private var isAddingNewGroup = false
    @State private var newGroup = ExpenseGroup()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ListBackground")
                    .edgesIgnoringSafeArea(.all)
                
                Group {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(1, anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        
                    } else {
                        List(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                }
                .navigationTitle("Groups")
                .background(Color("ListBackground"))
            }
            .onAppear {
                fetchNames()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        newGroup = ExpenseGroup()
                        isAddingNewGroup = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.indigo)
                    }
                }
            }
            .sheet(isPresented: $isAddingNewGroup) {
                NavigationView {
                    GroupEditor(group: $newGroup)
                }
            }
        }
    }
    
    func fetchNames() {
        isLoading = true

        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            isLoading = false

            if let error = error {
                print("Error fetching names: \(error)")
                return
            }
            
            self.names = snapshot?.documents.compactMap {
                $0.data()["email"] as? String
            } ?? []
        }
    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}
