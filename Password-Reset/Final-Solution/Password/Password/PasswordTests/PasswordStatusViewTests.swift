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

class PasswordStatusViewTests_ShouldNotReset_Good_OO: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShortNotThreeOfFour = "1"
    
    /*
     Verify that if the user loses focus, and then continues typing
     we flip between ✅ or ❌.

     shouldResetCriteria = false when validation called and criteria not met
     
     } else {
         // Focus lost (✅ or ❌)
         lengthCriteriaView.isCriteriaMet = lengthAndNoSpaceMet
     */
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        statusView.validate()
        
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShortNotThreeOfFour)
        statusView.validate()
        
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
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
        statusView.updateDisplay(twoOfFour)
        XCTAssertFalse(statusView.validate())
    }
    
    func testThreeOfFour() throws {
        statusView.updateDisplay(threeOfFour)
        XCTAssertTrue(statusView.validate())
    }

    func testFourOfFour() throws {
        statusView.updateDisplay(fourOfFour)
        XCTAssertTrue(statusView.validate())
    }
}

class PasswordStatusViewTests_Validate_Reset: XCTestCase {

    var statusView: PasswordStatusView!
    let twoOfFour = "12345678A"
    
    // Verify we won't reset the views if
    // three of four criteria aren't met
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    /*
     guard lengthCriteriaView.isCriteriaMet && metCriteria.count >= 3 else {
         ...
         shouldResetCriteria = false // here
         return false
     }

     */
    func testShouldNotReset() throws {
        statusView.updateDisplay(twoOfFour)
        statusView.validate()
        
        XCTAssertFalse(statusView.shouldResetCriteriaTest)
    }
}

class PasswordStatusViewTests_MissingCriteria_Reset: XCTestCase {

    var statusView: PasswordStatusView!
    let threeOfFourMissingLowercase = "12345678A!"
    
    // Missing criteria are reset if should be reset
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    /*
     if shouldResetCriteria {
         missingCriteria.forEach { $0.reset() } // (⚪️)
     }
     */
    
    func testMissingCriteriaReset() throws {
        statusView.updateDisplay(threeOfFourMissingLowercase)
        statusView.validate()
        
        XCTAssertTrue(statusView.lowerCaseCriteriaView.isResetImage)
    }
}


