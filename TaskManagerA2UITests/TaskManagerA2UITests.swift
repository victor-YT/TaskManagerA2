import XCTest

final class TaskManagerA2UITests: XCTestCase {

    func testAddTaskFlow() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["AddTaskButton"].tap()

        let tf = app.textFields["TitleTextField"]
        XCTAssertTrue(tf.waitForExistence(timeout: 2))
        tf.tap()
        tf.typeText("UI test")

        app.buttons["SaveTaskButton"].tap()

        XCTAssertTrue(app.staticTexts["UI test"].waitForExistence(timeout: 2))
    }
}
