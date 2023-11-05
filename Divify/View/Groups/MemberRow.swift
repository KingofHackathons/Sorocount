import SwiftUI

struct MemberRow: View {
    
    var member: Member
    
    var body: some View {
        HStack(spacing: 10) {
            Image(member.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 28, height: 28)
                .cornerRadius(50)
            
            Text(member.name)
        }
    }
}

//struct MemberRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberRow()
//    }
//}
