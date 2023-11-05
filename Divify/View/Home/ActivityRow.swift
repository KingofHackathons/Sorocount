import SwiftUI

struct ActivityRow: View {
    var activity: Activity
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(activity.userProfileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34)
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 4) {

                if activity.action == ActivityActions.created {
                    Text("\(activity.userName) created group \(activity.group)")
                        
                } else if activity.action == ActivityActions.paid {
                    if let expenseName = activity.expenseName {
                        Text("\(activity.userName) paid \(activity.paymentAmount) XLM towards \(expenseName)")
                    } else {
                        Text("\(activity.userName) paid \(activity.paymentAmount) XLM")
                    }

                } else if activity.action == ActivityActions.left {
                    Text("\(activity.userName) left the group")

                } else {
                    Text("Error")
                        .font(.caption)
                }
                
                Text("\(activity.group) • \(activity.date)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}


//struct ActivityRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityRow()
//    }
//}
