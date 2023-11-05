import SwiftUI

var platforms: [Platform] = [
    .init(name: "Xbox", imageName: "xbox.logo", color: .green),
    .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
    .init(name: "PC", imageName: "pc", color: .pink),
    .init(name: "Mobile", imageName: "iphone", color: .mint)]

var games: [Game] = [
    .init(name: "Minecraft", rating: "99"),
    .init(name: "God of War", rating: "98"),
    .init(name: "Fortnite", rating: "92"),
    .init(name: "Madden 2023", rating: "88")]

struct CreationView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        Text("Moin")
                            .font(.headline)
                    }
                    .frame(width: UIScreen.screenWidth * 0.92)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                Color.black.opacity(0.05)
                            )
                    }
                }
            }
            .navigationTitle("Add an Expense")
            .padding(.horizontal, 16)
        }
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationView()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}
