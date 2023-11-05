import SwiftUI

struct PaymentRow: View {
    
    var expense: Expense
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "dollarsign")
                .resizable()
                .scaledToFit()
            .frame(width: 18, height: 18)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                
                Text(expense.previewName)
                    .font(.caption)
            }
            
            Spacer()
            
            Text("\(expense.amount, specifier: "US$ %.2f")")
                .bold()
        }
    }
}

