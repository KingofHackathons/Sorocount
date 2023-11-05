import SwiftUI

struct WalletView: View {
    
    @Binding var publicKey: String
    @Binding var secretSeed: String
    @State private var showAlert: Bool = false
    @ObservedObject var viewModel = WalletViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            Section(header: Text("Public Key")) {
                TextField(publicKey, text: $publicKey)
                    .overlay(
                        Group {
                            if !publicKey.isEmpty {
                                Button(action: {
                                    withAnimation {
                                        publicKey = ""
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
            
            Section(header: Text("Secret Seed"), footer: Text("Do not share your secret seed with anyone, we will safely store it for you")) {
                TextField(secretSeed, text: $secretSeed)
                    .overlay(
                        Group {
                            if !secretSeed.isEmpty {
                                Button(action: {
                                    withAnimation {
                                        secretSeed = ""
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
            
            Section("Generate new keys") {
                Button {
                    
                } label: {
                    Text("Generate keys")
                        .bold()
                }
                .hCenter()

            }
        }
        .navigationTitle("Wallet")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button {
            presentationMode.wrappedValue.dismiss()
            savePublicKey()
            saveSecretSeed()
        } label: {
            Text("Save")
                .bold()
        })
        .alert(isPresented: $viewModel.isSuccessful) {
            Alert(
                title: Text("Success"),
                message: Text("Your wallet details have been updated successfully."),
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
    
    func savePublicKey() {
        if publicKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
        } else {
            viewModel.updatePublicKey(newKey: publicKey)
        }
    }
    
    func saveSecretSeed() {
        if secretSeed.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert = true
        } else {
            viewModel.updateSecretSeed(newSeed: secretSeed)
        }
    }
}
//
//struct WalletView_Previews: PreviewProvider {
//    static var previews: some View {
//        WalletView()
//    }
//}
