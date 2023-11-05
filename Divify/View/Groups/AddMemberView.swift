import SwiftUI

struct AddMemberView: View {
    @Binding var group: ExpenseGroup

    @State private var profileImage: String = ""
    @State private var memberName: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section("Add a member") {
                TextField("Profile Image Name", text: $profileImage)
                    .disableAutocorrection(true)
            }
            
            Section("Add a name") {
                TextField("Member Name", text: $memberName)
                    .disableAutocorrection(true)
            }
            
            Button {
                let newMember = Member(profileImage: profileImage, name: memberName)
                group.members.append(newMember)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Member")
            }
        }
        .navigationTitle("Add a Member")
        .navigationBarTitleDisplayMode(.inline)
    }
}
