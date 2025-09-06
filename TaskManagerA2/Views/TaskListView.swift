import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var vm: TaskListViewModel
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.tasks) { task in
                    TaskRowView(task: task) { vm.toggle(task) }
                }
                .onDelete(perform: vm.remove)
                .onMove(perform: vm.move)
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { EditButton() }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("AddTaskButton")
                }
            }
        }
        .sheet(isPresented: $showingAdd) {
            AddTaskView()
                .environmentObject(vm)
        }
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskListViewModel())
}
