import Foundation

enum AppError: LocalizedError {
    case emptyTitle
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
