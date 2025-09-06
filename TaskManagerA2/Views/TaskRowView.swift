import SwiftUI

struct TaskRowView: View {
    let task: Task
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.body)
                    .strikethrough(task.isDone, pattern: .solid, color: .secondary)

                if let notes = task.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            if let badge = badgeText {
                Text(badge)
                    .font(.caption2).bold()
                    .padding(.horizontal, 8).padding(.vertical, 4)
                    .background(Capsule().fill(badgeColor.opacity(0.15)))
                    .foregroundStyle(badgeColor)
            }
        }
        .contentShape(Rectangle())
    }

    private var badgeText: String? {
        if task.isDone { return "Completed" }
        guard let d = task.daysRemaining else { return nil }
        if d < 0 { return "Overdue \(-d)d" }
        if d == 0 { return "Today" }
        return "Remaining \(d)d"
    }

    private var badgeColor: Color {
        if task.isDone { return .secondary }
        if task.isOverdue { return .red }
        return .green
    }
}

#Preview {
    TaskRowView(task: Task(title: "Do Homework",
                           notes: "Write MVVM explanation",
                           dueDate: Calendar.current.date(byAdding: .day, value: 1, to: .now),
                           priority: Priority.high)) { }
}
