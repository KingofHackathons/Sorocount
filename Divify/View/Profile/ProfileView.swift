import SwiftUI
import Firebase

struct ProfileView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    @State private var showConnectingSheet = false
    @State private var userName: String = "Artemiy"
    
    var body: some View {
        NavigationView {
            List {
                HStack(spacing: 14) {
                    Image("nkoorty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(userName)
                            .font(.system(size: 18))
                            .bold()
                        
                        Text("GB6M...LWFR")
                            .font(.system(size: 16))
                    }
                    
                    Spacer()
                    
                    Button {
                        showConnectingSheet.toggle()
                    } label: {
                        Text("Connect")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.indigo)
                            .cornerRadius(16)
                    }
                    .sheet(isPresented: $showConnectingSheet) {
                        ConnectView()
                    }
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
                        DetailView(userName: $userName)
                    } label: {
                        Label("Details", systemImage: "info.circle")
                    }
                }
                
                Section {
                    NavigationLink {
                        WalletView()
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
