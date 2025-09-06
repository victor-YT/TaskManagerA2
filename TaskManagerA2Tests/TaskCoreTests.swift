import XCTest
@testable import TaskManagerA2

@MainActor
final class TaskCoreTests: XCTestCase {

    /// Verify that toggling the done state works correctly
    func testToggleDone() {
        var t = Task(title: "Test")
        XCTAssertFalse(t.isDone)
        t.toggleDone()
        XCTAssertTrue(t.isDone)
    }

    /// Verify that adding a task with an empty title throws the proper AppError
    func testValidation_EmptyTitle() {
        let vm = TaskListViewModel(useSeedData: false)

        XCTAssertThrowsError(
            try vm.addTask(title: "", notes: nil, dueDate: nil, priority: .medium, category: .personal)
        ) { error in
            XCTAssertTrue(error is AppError)
            if let appErr = error as? AppError {
                XCTAssertEqual(appErr, AppError.emptyTitle)
            }
        }
    }

    /// Verify that daysRemaining is stable and never negative for a future task
    func testDaysRemainingStable() {
        let due = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let t = Task(title: "D-Day", dueDate: due)

        XCTAssertNotNil(t.daysRemaining)
        XCTAssertGreaterThanOrEqual(t.daysRemaining ?? -99, 0)
    }

    /// Verify that adding a valid task increases the list count
    func testAddTaskSuccessIncreasesCount() throws {
        let vm = TaskListViewModel(useSeedData: false)
        XCTAssertEqual(vm.tasks.count, 0)

        try vm.addTask(title: "Weekly report",
                       notes: nil,
                       dueDate: nil,
                       priority: .medium,
                       category: .work)

        XCTAssertEqual(vm.tasks.count, 1)
        XCTAssertEqual(vm.tasks.first?.category, .work)
    }

    /// Verify that overdue tasks report negative remaining days and isOverdue flag
    func testOverdueDaysNegative() {
        let past = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let t = Task(title: "Overdue", dueDate: past)

        XCTAssertNotNil(t.daysRemaining)
        XCTAssertLessThan(t.daysRemaining ?? 0, 0)
        XCTAssertTrue(t.isOverdue)
    }
}

