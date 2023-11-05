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
                    Text("Error")
                        .font(.caption)

                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                if group.payments.count > 1 {
                    Text("\(group.payments.count) Payments")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                } else if group.payments.count == 1 {
                    Text("\(group.payments.count) Payment")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                } else {
                    Text("Error")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                if group.totalAmount == 0 {
                    Text("No payments")
                        .font(.caption)
                } else {
                    Text("\(group.totalAmount) XLM")
                        .font(.caption)
                }
                
            }
        }
    }
}

//
//struct GroupHomeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupHomeRow(group: expenseGroups[0])
//    }
//}
