import Foundation
import SwiftUI

// MARK: - Base task protocol (data + minimal behavior)

/// Minimal interface that any "task-like" model should provide.
/// Adopting this protocol lets us write view-model and view code
/// against abstractions (protocols) instead of concrete types (POP style).
protocol TaskProtocol: Identifiable, Codable, Equatable {
    var id: UUID { get }
    var title: String { get set }
    var notes: String? { get set }
    var isDone: Bool { get set }
    
    /// Toggles the completion state.
    mutating func toggleDone()
    
    /// Validates the current state. Throws an `AppError` on invalid input.
    func validate() throws
}

// MARK: - Scheduling capability (via protocol extension)

/// Marks a type as having an optional due date. Common, reusable logic
/// (e.g., days remaining / overdue) is provided by the protocol extension below.
protocol Schedulable {
    var dueDate: Date? { get set }
}

extension Schedulable {
    /// Remaining days in terms of "days"; negative means overdue
    var daysRemaining: Int? {
        guard let due = dueDate else { return nil }
        let cal = Calendar.current
        let startToday = cal.startOfDay(for: Date())
        let startDue = cal.startOfDay(for: due)
        return cal.dateComponents([.day], from: startToday, to: startDue).day
    }
    
    /// Convenience boolean exposing whether the due date is before today.
    var isOverdue: Bool {
        if let d = daysRemaining { return d < 0 }
        return false
    }
}

// MARK: - Priority
/// Priority levels used for visual cues (traffic-light dot) and potential future sorting.
enum Priority: Int, Codable, CaseIterable, Identifiable {
    case low = 0, medium = 1, high = 2
    var id: Int { rawValue }
    
    /// Short label for UI, accessibility and tests.
    var label: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
    
    /// UI color to render the traffic-light dot in the list row.
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}
