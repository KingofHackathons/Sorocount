import SwiftUI

struct DetailView: View {
    @Binding var userName: String
    @State private var showAlert: Bool = false

    var body: some View {
        List {
            Section(header: Text("username")) {
                TextField(userName, text: $userName)
                    .overlay(
                        Group {
                            if !userName.isEmpty {
                                Button(action: {
                                    withAnimation {
                                        userName = ""
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
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: saveUsername) {
            Text("Save")
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Username cannot be empty!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func saveUsername() {
        if userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
        } else {
            showAlert = false
        }
    }
}
