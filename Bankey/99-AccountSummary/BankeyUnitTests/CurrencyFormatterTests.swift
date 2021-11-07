//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by jrasmusson on 2021-11-07.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testBreakZeroDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(0.00)
        XCTAssertEqual(result.0, "0")
        XCTAssertEqual(result.1, "00")
    }
    
    // Challenge: You write
    func tesetDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929466.23")
    }

    // Challenge: You write
    func tesetZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
}
