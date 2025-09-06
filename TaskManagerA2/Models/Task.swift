import Foundation

struct Task: TaskProtocol, Schedulable {
    let id: UUID
    var title: String
    var notes: String?
    var isDone: Bool
    var dueDate: Date?
    var priority: Priority
    var category: TaskCategory

    init(id: UUID = UUID(),
         title: String,
         notes: String? = nil,
         isDone: Bool = false,
         dueDate: Date? = nil,
         priority: Priority = .medium,
         category: TaskCategory = .personal) {
        self.id = id
        self.title = title
        self.notes = notes
        self.isDone = isDone
        self.dueDate = dueDate
        self.priority = priority
        self.category = category
    }

    mutating func toggleDone() { isDone.toggle() }

    func validate() throws {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw AppError.emptyTitle
        }
        if let due = dueDate {
            let startToday = Calendar.current.startOfDay(for: Date())
            if due < startToday { throw AppError.pastDueDateNotAllowed }
        }
    }
}
