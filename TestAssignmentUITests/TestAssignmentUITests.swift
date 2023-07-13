//
//  TestAssignmentUITests.swift
//  TestAssignmentUITests
//
//  Created by Kevin Mihkelson on 12.07.2023.
//

import XCTest

final class TestAssignmentUITests: XCTestCase {
    
    func test_UIAddNewList() {
        let app = XCUIApplication()
        app.launch()
        
        let newListTextfield = app.textFields["NewList"]
        XCTAssertTrue(newListTextfield.waitForExistence(timeout: 1))
        
        newListTextfield.tap()
        
        newListTextfield.typeText("testing")
        XCTAssertEqual(newListTextfield.value as! String, "testing")
        
        let saveButton = app.buttons["SaveList"]
        
        saveButton.tap()
    }
}
