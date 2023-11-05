import SwiftUI

struct PaymentRow: View {
    
    var payment: Payment
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "dollarsign")
                .resizable()
                .scaledToFit()
            .frame(width: 18, height: 18)
            
            Text(payment.title)
            
            Spacer()
            
            Text("\(payment.amount) XLM")
                .bold()
        }
    }
}

//struct PaymentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentRow(payment: payments[0])
//    }
//}
