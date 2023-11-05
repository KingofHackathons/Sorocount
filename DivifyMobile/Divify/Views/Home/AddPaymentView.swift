import SwiftUI

struct AddPaymentView: View {
    @Binding var group: ExpenseGroup

    @State private var paymentName: String = ""
    @State private var amount: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section("Add a payment") {
                    TextField("Name your payment", text: $paymentName)
                        .disableAutocorrection(true)
                }
                
                Section("Set amount") {
                    TextField("Payment Amount", text: $amount)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                }
                
                Button {
                    if let intAmount = Int(amount) {
                        let newPayment = Payment(title: paymentName, amount: intAmount)
                        group.payments.append(newPayment)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Something went wrong with the the amount")
                    }
                } label: {
                    Text("Add Payment")
                        .bold()
                    
                }
                .hCenter()
            }
            .navigationTitle("Add a Payment")
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
        }
    }
}

//struct AddPaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPaymentView()
//    }
//}
