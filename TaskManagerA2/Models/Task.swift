import Foundation

/// High-level categories for tasks. Backed by `String` for easy JSON encoding/decoding.
enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case personal
    case work
    case shopping
    case others

    var id: String { rawValue }

    /// Localized/visible title for UI.
    var title: String {
        switch self {
        case .personal: return "personal"
        case .work:     return "work"
        case .shopping: return "shopping"
        case .others:   return "others"
        }
    }
    
    /// An emoji that visually represents the category in the list row.
    var emoji: String {
        switch self {
        case .personal: return "👤"
        case .work:     return "💼"
        case .shopping: return "🛒"
        case .others:   return "📌"
        }
    }
}

/// Concrete task model used by the app.
/// - Conforms to `TaskProtocol` (POP), and `Schedulable` to gain due-date utilities.
/// - Keeps business logic self-contained (e.g. validation).
struct Task: TaskProtocol, Schedulable {
    let id: UUID
    var title: String
    var notes: String?
    var isDone: Bool
    var dueDate: Date?
    var priority: Priority
    var category: TaskCategory

    /// Designated initializer with sensible defaults so tests and seeds are concise.
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

    /// Flip completion state.
    mutating func toggleDone() { isDone.toggle() }

    /// Validate domain rules and surface `AppError`s back to the caller.
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
