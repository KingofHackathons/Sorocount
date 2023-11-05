import SwiftUI

struct GroupHomeRow: View {
    
    @ObservedObject var group: ExpenseGroup
    
    var body: some View {
        HStack {
            Image(group.image)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 4) {
                Text(group.title)
                
                if group.members.count > 1 {
                    Text("\(group.members.count) Members")
                        .font(.caption)
                        
                } else if group.members.count == 1 {
                    Text("\(group.members.count) Member")
                        .font(.caption)

                } else {
                    Text("No Members")
                        .font(.caption)

                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                if group.expenses.count > 1 {
                    Text("\(group.expenses.count) Payments")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                } else if group.expenses.count == 1 {
                    Text("\(group.expenses.count) Payment")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                } else {
                    Text("No Payments")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                if group.totalAmount == 0 {
                    Text("No payments")
                        .font(.caption)
                } else {
                    Text("\(group.totalAmount, specifier: "US$ %.2f")")
                        .font(.caption)
                }
                
            }
        }
    }
}
