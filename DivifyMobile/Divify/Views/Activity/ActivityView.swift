import SwiftUI
import Firebase

struct ActivityView: View {
    
    @EnvironmentObject var activityData: ActivityData

    var body: some View {
        NavigationView {
            List {
                Section("Activity") {
                    ForEach(activityData.activities) { activity in
                        ActivityRow(activity: activity)
                    }
                }
            }
            .navigationTitle("Activity")
        }
    }
}

//struct Activity_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
