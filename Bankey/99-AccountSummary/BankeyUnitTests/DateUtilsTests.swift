//
//  DateUtilsTests.swift
//  BankeyUnitTests
//
//  Created by jrasmusson on 2021-11-09.
//

import Foundation
import XCTest

@testable import Bankey

class DateUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testMonthDayYear() throws {
        let date = makeDate(day: 7, month: 11, year: 2000)
        XCTAssertEqual(date.monthDayYearString, "Nov 7, 2000")
    }
    
    private func makeDate(day: Int, month: Int, year: Int) -> Date {
        let userCalendar = Calendar.current
        var components = DateComponents()
         
        components.day = day
        components.month = month
        components.year = year
         
        return userCalendar.date(from: components)!
    }
}
