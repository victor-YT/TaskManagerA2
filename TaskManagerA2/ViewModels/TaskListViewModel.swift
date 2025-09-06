import Foundation
import SwiftUI

/// The source for the task list (MVVM).
/// - Exposes a published `tasks` array to SwiftUI views.
/// - Encapsulates loading, sorting, mutations and validation orchestration.
/// - Marked `@MainActor` because it touches UI-observed state.
@MainActor
final class TaskListViewModel: ObservableObject {
    
    /// UI-observed list of tasks.
    @Published var tasks: [Task] = []

    /// Optionally loads seed data for demos/tests.
    init(useSeedData: Bool = true) {
        if useSeedData { loadSeed() }
    }

    /// Load demo data from `seed_tasks.json` and apply the current sort.
    func loadSeed() {
        let loaded: [Task] = Bundle.main.decode("seed_tasks.json")
        tasks = sortTasks(loaded)
    }

    /// Stable sort:
    /// 1) incomplete first
    /// 2) then earlier due dates
    /// 3) then alphabetical by title
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
    func addTask(title: String,
                 notes: String?,
                 dueDate: Date?,
                 priority: Priority,
                 category: TaskCategory = .personal) throws {
        let t = Task(
            title: title,
            notes: notes,
            isDone: false,
            dueDate: dueDate,
            priority: priority,
            category: category
        )
        try t.validate()
        tasks.insert(t, at: 0)
        tasks = sortTasks(tasks)
    }
    
    /// Remove tasks at the given offsets (List swipe-to-delete).
    func remove(at offsets: IndexSet) { tasks.remove(atOffsets: offsets) }
    
    /// Reorder tasks (List drag-to-reorder).
    func move(from source: IndexSet, to destination: Int) { tasks.move(fromOffsets: source, toOffset: destination) }

    /// Toggle completion for a specific task and re-sort.
    func toggle(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[idx].toggleDone()
        tasks = sortTasks(tasks)
    }

    /// Replace an existing task with a new value and re-sort.
    func update(_ task: Task) {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[idx] = task
        tasks = sortTasks(tasks)
    }
}
