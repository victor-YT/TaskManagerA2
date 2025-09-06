import Foundation
import SwiftUI

@MainActor
final class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    init(useSeedData: Bool = true) {
        if useSeedData { loadSeed() }
    }

    func loadSeed() {
        let loaded: [Task] = Bundle.main.decode("seed_tasks.json")
        tasks = sortTasks(loaded)
    }

    func sortTasks(_ arr: [Task]) -> [Task] {
        arr.sorted { a, b in
            if a.isDone != b.isDone { return !a.isDone }
            switch (a.dueDate, b.dueDate) {
            case let (d1?, d2?): return d1 < d2
            case (nil, _?): return false
            case (_?, nil): return true
            case (nil, nil): return a.title.lowercased() < b.title.lowercased()
            }
        }
    }

    /// Now throws errors to the caller (handled in AddTaskView to display alerts)
    func addTask(title: String, notes: String?, dueDate: Date?, priority: Priority) throws {
        var t = Task(title: title, notes: notes, dueDate: dueDate, priority: priority)
        try t.validate()
        tasks.insert(t, at: 0)
        tasks = sortTasks(tasks)
    }

    func remove(at offsets: IndexSet) { tasks.remove(atOffsets: offsets) }
    func move(from source: IndexSet, to destination: Int) { tasks.move(fromOffsets: source, toOffset: destination) }

    func toggle(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[idx].toggleDone()
        tasks = sortTasks(tasks)
    }

    func update(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[idx] = task
        tasks = sortTasks(tasks)
    }
}
