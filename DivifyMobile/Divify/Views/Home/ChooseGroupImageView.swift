import SwiftUI

struct ChooseGroupImageView: View {
    
    @Binding var groupImage: String
    @State var selectedImage: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    let imageOptions = ["group1", "group2", "group3", "group4"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image(selectedImage ?? groupImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .cornerRadius(100)
                
                HStack(spacing: 14) {
                    ForEach(imageOptions, id: \.self) { img in
                        Button {
                            selectedImage = img
                        } label: {
                            Image(img)
                                .resizable()
                                .scaledToFill()
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
                groupImage = selectedImage ?? groupImage
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .bold()
            })
        }
    }
}
