import SwiftUI
import Firebase

struct AddMemberView: View {
    @Binding var group: ExpenseGroup
    @State private var memberName: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var db = Firestore.firestore()

    var body: some View {
        NavigationView {
            List {
                Section("Add user id") {
                    TextField("User ID", text: $memberName)
                        .disableAutocorrection(true)
                }
                
                Button {
                    let newMember = Member(profileImage: profileViewModel.profileImage, name: memberName, previewName: profileViewModel.userName, owedAmount: 0, hasPaid: false)
                    group.members.append(newMember)
                    addMemberToFirebase(member: newMember)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Add Member")
                        .bold()
                }
                .hCenter()
            }
            .navigationTitle("Add a Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                profileViewModel.fetchUsername()
                profileViewModel.fetchProfileImage()
            }
        }
    }
    
    func addMemberToFirebase(member: Member) {
        let memberData: [String: Any] = [
            "uid": member.name,
            "previewName": member.previewName
        ]
        
        guard !group.id.isEmpty else {
            print("Invalid Group ID provided.")
            return
        }
        
        db.collection("groups").document(group.id).collection("members").addDocument(data: memberData)
    }
}
