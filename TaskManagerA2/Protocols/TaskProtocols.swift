import Foundation
import SwiftUI

// Base task protocol (data + basic behavior)
protocol TaskProtocol: Identifiable, Codable, Equatable {
    var id: UUID { get }
    var title: String { get set }
    var notes: String? { get set }
    var isDone: Bool { get set }
    mutating func toggleDone()
    func validate() throws
}

// Schedulable capability (provides common logic via protocol extension)
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
    var isOverdue: Bool {
        if let d = daysRemaining { return d < 0 }
        return false
    }
}

// Priority capability
enum Priority: Int, Codable, CaseIterable, Identifiable {
    case low = 0, medium = 1, high = 2
    var id: Int { rawValue }
    var label: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .yellow
        case .high: return .red
        }
    }
}
