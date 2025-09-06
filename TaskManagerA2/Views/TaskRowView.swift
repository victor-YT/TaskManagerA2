import SwiftUI

struct TaskRowView: View {
    let task: Task
    var onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Completion toggle button
            Button(action: onToggle) {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
            }
            .buttonStyle(.plain)

            // Category emoji
            Text(task.category.emoji)
                .font(.title3)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    // Title
                    Text(task.title)
                        .font(.body)
                        .strikethrough(task.isDone, pattern: .solid, color: .secondary)

                    // Priority indicator (traffic light dot)
                    Circle()
                        .fill(task.priority.color)
                        .frame(width: 8, height: 8)
                        .accessibilityLabel("Priority \(task.priority.label)")
                }

                // Notes (optional)
                if let notes = task.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            // Deadline badge
            if let badge = badgeText {
                Text(badge)
                    .font(.caption2).bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(badgeColor.opacity(0.15)))
                    .foregroundStyle(badgeColor)
            }
        }
        .contentShape(Rectangle())
    }

    // Badge text for deadline
    private var badgeText: String? {
        if task.isDone { return "Completed" }
        guard let d = task.daysRemaining else { return nil }
        if d < 0 { return "Overdue \(-d)d" }
        if d == 0 { return "Today" }
        return "Remaining \(d)d"
    }

    // Badge color logic
    private var badgeColor: Color {
        if task.isDone { return .secondary }
        if task.isOverdue { return .red }
        return .green
    }
}

#Preview {
    TaskRowView(task: Task(
        title: "Do Homework",
        notes: "Write MVVM explanation",
        dueDate: Calendar.current.date(byAdding: .day, value: 1, to: .now),
        priority: .high,
        category: .work
    )) { }
}
