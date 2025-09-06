import SwiftUI

struct ContentView: View {
    var body: some View {
        TaskListView()
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskListViewModel())
}
