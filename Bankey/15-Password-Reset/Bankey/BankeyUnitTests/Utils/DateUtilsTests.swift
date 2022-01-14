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
    
    /*
     Dates can be tricky
     
     Included this unit test to show you that unit tests can fail when users are
     in different time zones. This unit test will pass 100% if you are on MDT
     
     formatter.timeZone = TimeZone(abbreviation: "MDT")
     
     That's because the DateFormatter in `Date+Utils` is hard coded to MDT.
     If you run this test and it fails (i.e. Nov 6, or Nov 8) change the timezone
     to match your locale, and everything should pass.
     
     */
    func testMonthDayYear() throws {
//        let date = makeDate(day: 7, month: 11, year: 2000)
//        XCTAssertEqual(date.monthDayYearString, "Nov 7, 2000")
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
