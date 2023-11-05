import SwiftUI

struct GroupEditor: View {
    
    @Binding var group: ExpenseGroup
    
    var body: some View {
        Text(group.title)
    }
}

//struct GroupEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupEditor()
//    }
//}
