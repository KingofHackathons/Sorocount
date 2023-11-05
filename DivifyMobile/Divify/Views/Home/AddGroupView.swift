import SwiftUI
import Firebase

struct AddGroupView: View {
    
    @Binding var groups: [ExpenseGroup]
    @State private var groupName: String = ""
    @State var groupImage: String = "group1"
    @State var isShowingGroupImageChoose: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var groupServerData = GroupDataViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State private var db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Group Image")) {
                    VStack {
                        Image(groupImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(50)
                        
                        Button {
                            isShowingGroupImageChoose.toggle()
                        } label: {
                            Text("Change Group Image")
                                .foregroundColor(.blue)
                                .font(.system(size: 16))
                                .bold()
                        }
                    }
                    .hCenter()
                }
                
                Section(header: Text("Group Name")) {
                    TextField(groupName, text: $groupName)
                        .overlay(
                            Group {
                                if !groupName.isEmpty {
                                    Button(action: {
                                        withAnimation {
                                            groupName = ""
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.trailing, 2)
                                }
                            }
                            , alignment: .trailing
                        )
                        .environment(\.isEnabled, true)
                }
            }
            .navigationTitle("Create Group")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.red)
                                }, trailing: Button("Save") {
                                    addGroupToFirebase()
                                    presentationMode.wrappedValue.dismiss()
                                })
            .sheet(isPresented: $isShowingGroupImageChoose) {
                ChooseGroupImageView(groupImage: $groupImage)
            }
            .onAppear {
                groupServerData.fetchGroups()
                profileViewModel.fetchUsername()
            }
        }
    }
    
    func addGroupToFirebase() {
        let groupData: [String: Any] = [
            "groupName": groupName,
            "groupImage": groupImage
        ]
        
        var reference: DocumentReference? = nil
        reference = db.collection("groups").addDocument(data: groupData) { err in
            if let err = err {
                print("Error adding group: \(err)")
            } else {
                print("Group added with ID: \(reference!.documentID)")
                self.addMeAsMemberToGroup(groupId: reference!.documentID)
            }
        }
    }

    func addMeAsMemberToGroup(groupId: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: Could not get current user's UID.")
            return
        }

        let memberData: [String: Any] = [
            "uid": uid,
            "previewName": profileViewModel.userName
        ]

        db.collection("groups").document(groupId).collection("members").document(uid).setData(memberData) { err in
            if let err = err {
                print("Error adding member: \(err)")
            } else {
                print("Member added successfully.")
            }
        }
    }
}
