import SwiftUI

struct LoginView: View {
    
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @StateObject var signupModel: SignupViewModel = SignupViewModel()
    
    @State var useFaceID: Bool = false
    @State var isSigningUp: Bool = false
    var body: some View {
        ZStack {
            Color("ListBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .hCenter()
                    .offset(x: -10)
                
                if isSigningUp {
                    Text("Hey, \nSign up to Divify")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .transition(.opacity)
                        .hLeading()
                        .padding(.bottom, 40)
                        .frame(height: 126)
                } else {
                    Text("Hey, \nLogin into Divify")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .transition(.opacity)
                        .hLeading()
                        .padding(.bottom, 40)
                        .frame(height: 126)
                }
                
                if isSigningUp {
                    TextField("Email", text: $signupModel.email)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.05)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } else {
                    TextField("Email", text: $loginModel.email)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.05)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                if isSigningUp {
                    SecureField("Password", text: $signupModel.password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.05)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .padding(.top, 2)
                } else {
                    SecureField("Password", text: $loginModel.password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    Color.black.opacity(0.05)
                                )
                        }
                        .textInputAutocapitalization(.never)
                        .padding(.top, 2)
                }
                
                if isSigningUp {
                    Button {
                        Task {
                            do {
                                try await signupModel.signUp()
                            } catch {
                                signupModel.errorMsg = error.localizedDescription
                                signupModel.showError.toggle()
                            }
                        }
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .hCenter()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.black)
                            )
                    }
                    .padding(.vertical, 40)
                    .disabled(signupModel.email == "" || signupModel.password == "")
                    .opacity(signupModel.email == "" || signupModel.password == "" ? 0.3 : 0.8)
                } else {
                    Button {
                        Task {
                            do {
                                try await loginModel.loginUser()
                            } catch {
                                loginModel.errorMsg = error.localizedDescription
                                loginModel.showError.toggle()
                            }
                        }
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .hCenter()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.black)
                            )
                    }
                    .padding(.vertical, 40)
                    .disabled(loginModel.email == "" || loginModel.password == "")
                    .opacity(loginModel.email == "" || loginModel.password == "" ? 0.3 : 0.8)
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isSigningUp.toggle()
                    }
                } label: {
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.black.opacity(0.7))
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            .alert(loginModel.errorMsg, isPresented: $loginModel.showError) {   }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }

}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

