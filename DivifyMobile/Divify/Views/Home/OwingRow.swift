import SwiftUI

struct OwingRow: View {
    
    var member: Member
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 6) {
                Text("You owe")
                
                HStack(spacing: 4) {
                    Image(member.profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .cornerRadius(50)
                    
                    Text(member.previewName)
                }
                
                Text("\(member.owedAmount, specifier: "US$ %.2f")")
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    if member.hasPaid {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                    }
                }
            }
            HStack {
                Text("\(member.owedAmount * 8.13, specifier: "Pay %.2f XLM ")")
                    .font(.system(size: 14))
                
                Button {
                    
                } label: {
                    Text(member.hasPaid ? "Paid" : "Pay")
                        .padding(.vertical, 3)
                        .padding(.horizontal, 7)
                        .foregroundColor(.white)
                        .background(member.hasPaid ? .gray : .blue)
                        .cornerRadius(6)
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    OwingRow(member: members[1])
//}
