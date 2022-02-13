//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Rasmusson, Jonathan on 2022-01-08.
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShouldReset: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    /*
     Verify that as the user is typing
     we flip between ✅ or ⚪️
     
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
         lengthAndNoSpaceMet
             ? lengthCriteriaView.isCriteriaMet = true
             : lengthCriteriaView.reset()
     */
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }
}

class PasswordStatusViewTests_Validate: XCTestCase {

    var statusView: PasswordStatusView!
    let twoOfFour = "12345678A"
    let threeOfFour = "12345678Aa"
    let fourOfFour = "12345678Aa!"

    // Verify is valid if three of four criteria met
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }

    func testFourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
}


