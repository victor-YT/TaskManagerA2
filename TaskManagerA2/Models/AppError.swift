import Foundation

/// Domain-specific errors surfaced by the app.
/// - Note: Conforms to `LocalizedError` so we can show human-readable messages in alerts.
enum AppError: LocalizedError {
    /// The task title is empty after trimming whitespaces/newlines.
    case emptyTitle
    /// The provided due date is earlier than today (start of day).
    case pastDueDateNotAllowed

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Task title can not be empty."
        case .pastDueDateNotAllowed:
            return "Due date must be today or later."
        }
    }
}
