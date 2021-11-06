//
//  DoubleTests.swift
//  BankeyUnitTests
//
//  Created by jrasmusson on 2021-11-06.
//

import XCTest

@testable import Bankey

class DoubleTests: XCTestCase {
    var amount: Double!
    
    override func setUp() {
        super.setUp()
        amount = 929466.23
    }
    
    func testShouldFormatAsCurrency() throws {
        let dollarsFormatted = amount.dollarsFormatted
        XCTAssertEqual(dollarsFormatted, "$929,466.23")
    }
    
    
}
