import SwiftUI

struct DetailView: View {
    @Binding var userName: String
    @State private var showAlert: Bool = false
    @ObservedObject var viewModel = DetailViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section(header: Text("profile image")) {
                VStack {
                    Image("cat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .cornerRadius(50)
                    
                    Button {
                        
                    } label: {
                        Text("Change Profile Image")
                            .foregroundColor(.blue)
                            .font(.system(size: 16))
                            .bold()
                    }
                }
                .hCenter()
            }
            
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
        .navigationBarItems(trailing: Button {
            presentationMode.wrappedValue.dismiss()
            saveUsername()
        } label: {
            Text("Save")
                .bold()
        })
        .alert(isPresented: $viewModel.isSuccessful) {
            Alert(
                title: Text("Success"),
                message: Text("Username updated successfully."),
                dismissButton: .default(Text("OK"))
            )
        }

        .alert(isPresented: $showAlert) {
            if let error = viewModel.error {
                return Alert(
                    title: Text("Error"),
                    message: Text(error),
                    dismissButton: .default(Text("OK"))
                )
            } else {
                return Alert(
                    title: Text("Error"),
                    message: Text("Username cannot be empty!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func saveUsername() {
        if userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
        } else {
            viewModel.updateUsername(newName: userName)
        }
    }
}
