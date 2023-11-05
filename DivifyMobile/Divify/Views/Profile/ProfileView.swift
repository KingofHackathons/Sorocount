import SwiftUI
import Firebase

struct ProfileView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    @State private var showConnectingSheet = false
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            List {
                HStack(spacing: 14) {
                    Image(viewModel.profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.userName)
                            .font(.system(size: 18))
                            .bold()
                        
                        Text(formatPublicKey(viewModel.publicKey))
                            .font(.system(size: 16))
                    }
                    
                    Spacer()
                    
                    Text("Connected")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.indigo)
                        .cornerRadius(16)
                }
                
                Section {
                    NavigationLink {
                        ScanCodeView()
                    } label: {
                        Label("Scan code", systemImage: "qrcode")
                    }
                    
                    NavigationLink {
                        TransactionView()
                    } label: {
                        Label("Past Transactions", systemImage: "paperplane")
                    }
                    
                    NavigationLink {
                        DetailView(userName: $viewModel.userName)
                    } label: {
                        Label("Details", systemImage: "info.circle")
                    }
                }
                
                Section {
                    NavigationLink {
                        WalletView(publicKey: $viewModel.publicKey, secretSeed: $viewModel.secretSeed)
                    } label: {
                        Label("Wallet", systemImage: "wallet.pass")
                    }

                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                
                VStack {
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(20)
                    
                    Text("Divify")
                    
                    Text("Version 0.1")
                        .font(.caption)
                }
                .hCenter()
                .listRowBackground(Color.clear)
  
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUsername()
            viewModel.fetchProfileImage()
            viewModel.fetchPublicKey()
            viewModel.fetchSecretSeed()
        }
    }
    
    func formatPublicKey(_ key: String) -> String {
        guard key.count > 8 else { return key }
        let startIndex = key.startIndex
        let firstFour = key[..<key.index(startIndex, offsetBy: 4)]
        let lastFour = key[key.index(key.endIndex, offsetBy: -4)...]
        return "\(firstFour)...\(lastFour)"
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
