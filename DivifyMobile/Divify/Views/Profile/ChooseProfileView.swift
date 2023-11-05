import SwiftUI

struct ChooseProfileView: View {
    
    @Binding var profileImage: String
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = ChooseProfileViewModel()
    
    @State private var showAlert: Bool = false
    @State private var selectedImage: String?
    
    let imageOptions = ["cat", "dog", "monkey", "lion"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image(selectedImage ?? profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                
                HStack(spacing: 14) {
                    ForEach(imageOptions, id: \.self) { img in
                        Button {
                            selectedImage = img
                        } label: {
                            Image(img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(selectedImage == img ? Color.blue : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(.top, 32)
                
                Spacer()
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .background(Color("ListBackground"))
            .navigationTitle("Choose Profile Image")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button {
                presentationMode.wrappedValue.dismiss()
                saveProfileImage()
                
            } label: {
                Text("Save")
                    .bold()
            })
            .alert(isPresented: $viewModel.isSuccessful) {
                Alert(
                    title: Text("Success"),
                    message: Text("Image updated successfully."),
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
                        message: Text("Image cannot be empty!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    func saveProfileImage() {
        if let selectedImg = selectedImage {
            profileImage = selectedImg
            viewModel.updateProfileImage(newImage: selectedImg)
        } else {
            showAlert = true
        }
    }
}
