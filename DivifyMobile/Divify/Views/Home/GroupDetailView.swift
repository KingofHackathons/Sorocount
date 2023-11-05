import SwiftUI

struct GroupDetailView: View {
    
    @Binding var group: ExpenseGroup
    
    @State private var isPickingPhoto = false
    @State private var isAddingMember = false
    @State private var isAddingPayment = false
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                HStack(alignment: .top, spacing: 14) {
                    Image(group.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 46, height: 46)
                        .cornerRadius(50)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(group.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 4) {
                            Text("You owe")
                            
                            Text("\(group.owedAmount) XLM")
                                .fontWeight(.semibold)
                        }
                    }
                }
                
                HStack(alignment: .bottom) {
                    Text("Members")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    if group.members.count >= 1 {
                        Text("Total: \(group.members.count)")
                            .font(.caption)
                    } else {
                        Text("Error")
                    }
                }
                
                ForEach(group.members) { member in
                    MemberRow(member: member)
                }
                
                Button {
                    isAddingMember.toggle()
                } label: {
                    Label("Add Member", systemImage: "plus")
                }
                
                HStack(alignment: .bottom) {
                    Text("Payments")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    if group.payments.count >= 1 {
                        Text("Total: \(group.payments.count)")
                            .font(.caption)
                    } else {
                        Text("Error")
                    }
                }
                
                ForEach(group.payments) { payment in
                    PaymentRow(payment: payment)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = group.payments.firstIndex(where: { $0.id == payment.id }) {
                                    group.payments.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                
                Button {
                    isAddingPayment.toggle()
                } label: {
                    Label("Add Payment", systemImage: "plus")
                }
            }
            
            Section(header: Text("Transactions")) {
                
            }
        }
        .navigationTitle("Group")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingMember) {
            AddMemberView(group: $group)
        }
        .sheet(isPresented: $isAddingPayment) {
            AddPaymentView(group: $group)
        }
        
    }
}

//struct GroupDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupDetailView(group: .constant(ExpenseGroup.example))
//    }
//}
