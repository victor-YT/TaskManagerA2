import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var vm: TaskListViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var hasDueDate: Bool = true
    @State private var dueDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var priority: Priority = .medium

    @State private var alertMessage: String?

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("e.g. Finish iOS assignment", text: $title)
                        .accessibilityIdentifier("TitleTextField")
                }

                Section("Options") {
                    Toggle("Set Due Date", isOn: $hasDueDate.animation())
                    if hasDueDate {
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }

                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases) { p in
                            Text(p.label).tag(p)
                        }
                    }

                    TextField("Notes (Optional)", text: $notes)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        do {
                            try vm.addTask(
                                title: title,
                                notes: notes.isEmpty ? nil : notes,
                                dueDate: hasDueDate ? dueDate : nil,
                                priority: priority
                            )
                            // Dismiss asynchronously after success to avoid “Publishing changes…” warning
                            DispatchQueue.main.async { dismiss() }
                        } catch {
                            let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                            alertMessage = message
                        }
                    }
                    .bold()
                    .accessibilityIdentifier("SaveTaskButton")
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        .alert("Error", isPresented: Binding(
            get: { alertMessage != nil },
            set: { if !$0 { alertMessage = nil } }
        ), actions: {
            Button("OK", role: .cancel) { alertMessage = nil }
        }, message: {
            Text(alertMessage ?? "")
        })
    }
}

#Preview {
    AddTaskView().environmentObject(TaskListViewModel())
}
