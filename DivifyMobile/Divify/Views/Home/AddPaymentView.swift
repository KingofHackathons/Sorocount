import SwiftUI
import Firebase

struct AddExpenseView: View {
    @Binding var group: ExpenseGroup

    @State var expenseName: String = ""
    @State var amount: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var groupDataViewModel = GroupDataViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            List {
                Section("Add an expense") {
                    TextField("Name your payment", text: $expenseName)
                        .disableAutocorrection(true)
                }
                
                Section("Set amount") {
                    TextField("Payment Amount", text: $amount)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                }
                
                Button {
                    if let doubleAmount = Double(amount) {
                        let newExpense = Expense(title: expenseName, amount: doubleAmount, previewName: profileViewModel.userName, author: Auth.auth().currentUser?.uid ?? "Unknown UID")
                        group.expenses.append(newExpense)
                        addPaymentToFirebase(expense: newExpense)
                        
                        presentationMode.wrappedValue.dismiss()
                    
                    } else {
                        print("Something went wrong with the amount")
                    }
                } label: {
                    Text("Add Expense")
                        .bold()
                }
                .hCenter()
            }
            .navigationTitle("Add an Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                profileViewModel.fetchUsername()
            }
        }
    }
    
    func addPaymentToFirebase(expense: Expense) {
        let paymentData: [String: Any] = [
            "title": expense.title,
            "amount": expense.amount,
            "previewName": expense.previewName,
            "uid": expense.author
        ]
        
        guard !group.id.isEmpty else {
            print("Invalid Group ID provided.")
            return
        }
        
        db.collection("groups").document(group.id).collection("payments").addDocument(data: paymentData)
    }
}
