import XCTest
@testable import TaskManagerA2

@MainActor
final class TaskCoreTests: XCTestCase {

    func testToggleDone() {
        var t = Task(title: "Test")
        XCTAssertFalse(t.isDone)
        t.toggleDone()
        XCTAssertTrue(t.isDone)
    }

    func testValidation_EmptyTitle() {
        let vm = TaskListViewModel(useSeedData: false)

        XCTAssertThrowsError(
            try vm.addTask(title: "", notes: nil, dueDate: nil, priority: .medium)
        ) { error in
            // make sure error type
            XCTAssertTrue(error is AppError)
            if let appErr = error as? AppError {
                XCTAssertEqual(appErr, AppError.emptyTitle)
            }
        }
    }

    func testDaysRemainingStable() {
        let due = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let t = Task(title: "D-Day", dueDate: due)

        XCTAssertNotNil(t.daysRemaining)
        XCTAssertGreaterThanOrEqual(t.daysRemaining ?? -99, 0)
    }
}
