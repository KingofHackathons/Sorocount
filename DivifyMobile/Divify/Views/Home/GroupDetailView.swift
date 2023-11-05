import SwiftUI
import AlertToast

struct GroupDetailView: View {
    
    @Binding var group: ExpenseGroup
    
    @State private var isPickingPhoto = false
    @State private var isAddingMember = false
    @State private var isAddingPayment = false
    @State private var showToast = false
    
    @ObservedObject var groupDataViewModel = GroupDataViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
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
                            
                            Text("\(group.owedAmount, specifier: "US$ %.2f")")
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
                    Text("Expenses")
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    if group.expenses.count >= 1 {
                        Text("Total: \(group.expenses.count)")
                            .font(.caption)
                    } else {
                        Text("No Expenses Yet")
                    }
                }
                
                ForEach(group.expenses) { expense in
                    PaymentRow(expense: expense)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = group.expenses.firstIndex(where: { $0.id == expense.id }) {
                                    group.expenses.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                
                Button {
                    isAddingPayment.toggle()
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
            
            Section(header: Text("Transactions")) {
                ForEach(group.members) { member in
                    if member.previewName == profileViewModel.userName {
                        
                    } else {
                        OwingRow(member: member)
                            .onTapGesture {
                                showToast.toggle()
                            }
                    }
                }
            }
        }
        .navigationTitle("Group")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingMember) {
            AddMemberView(group: $group)
        }
        .sheet(isPresented: $isAddingPayment) {
            groupDataViewModel.fetchGroups()
        } content: {
            AddExpenseView(group: $group)
        }
        .onAppear {
            profileViewModel.fetchUsername()
        }
        .toast(isPresenting: $showToast){
            AlertToast(displayMode: .hud, type: .regular, title: "Minting in Progress")
        }
    }
}
