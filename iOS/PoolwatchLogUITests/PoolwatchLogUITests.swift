import XCTest

final class PoolwatchLogUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITestMode"]
        app.launch()
    }

    func testAddButtonOpensSheetAndSaves() {
        app.buttons["addButton"].tap()
        let saveButton = app.buttons["editSaveButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 2))
        saveButton.tap()
    }

    func testFreeLimitTriggersPaywall() {
        for _ in 0..<(10 + 1) {
            app.buttons["addButton"].tap()
            let saveButton = app.buttons["editSaveButton"]
            if saveButton.waitForExistence(timeout: 2) {
                saveButton.tap()
            }
        }
        let paywallClose = app.buttons["paywallCloseButton"]
        XCTAssertTrue(paywallClose.waitForExistence(timeout: 2))
        paywallClose.tap()
    }

    func testKeyboardDismissesOnTapOutside() {
        app.buttons["addButton"].tap()
        let textFields = app.textFields
        if textFields.count > 0 {
            let field = textFields.element(boundBy: 0)
            field.tap()
            field.typeText("Sample")
            app.staticTexts.firstMatch.tap()
            XCTAssertFalse(app.keyboards.element.exists)
        }
        app.buttons["editCancelButton"].tap()
    }

    func testSettingsSheetOpensAndCloses() {
        app.buttons["settingsButton"].tap()
        let done = app.buttons["settingsDoneButton"]
        XCTAssertTrue(done.waitForExistence(timeout: 2))
        done.tap()
    }
}
