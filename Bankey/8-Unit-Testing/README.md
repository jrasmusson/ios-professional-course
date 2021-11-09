# Unit Testing

- Show how to add unit tests to existing project
- Talk about code that is suitable for unit testing
 - Anything with logic we can extract out and test as a small indiviudal unit

## CurrencyFormatter

```swift
class CurrencyFormatterTest: XCTestCase {
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
}
```

Challenge: Have students write a test for checking the balance with zeros.

Solution:

```swift
    func testBreakZeroDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(0.00)
        XCTAssertEqual(result.0, "0")
        XCTAssertEqual(result.1, "00")
    }
```

Another challenge. Write two more test cases:

- one testing our `dollarsFormatted` func for some amount.
- another for zero amount

```swift
    // Challenge: You write
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }

    // Challenge: You write
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
```

Some overlap of tests is OK.

## DateUtil

What's another class we could write some tests for. What about `DateUtil`?

Challenge: See if you can:

- Add a new test file called `DateUtilsTests`.
- Write a test for `monthDayYearString`.
- And verify it returns the result we'd like.

Good luck!

Talk about some of the challenges here. 

- Dates are tricky.
- Don't want to instantiate `Date()` because that will change every day.
- So we need to create a concrete date like this.

```swift
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
```

Could extract this function to `Date+Utils` if we thought useful. Will leave here for now.

Discussion

- Hopefully you've now got a test of what unit tests are and how they work
- They are a form of automated testing
- But they also affect our design
- You see to make things more testable, you have to write your code in a certain way - more often than not a good one
 - Need to extact funcs
 - Design pieces into smaller componets
 - Because all these make things easier to test
- Tests are also a form of documentation and communication
- When you write a unit test, you are demonstrating the intent behind how something works
- The beauty of this, is this is the documentation is executable.
- And you can run these everytime you make a change or want to verify everything still works
- Often run as part of a continuous integration process which is run everytime someone checks code in

OK - good for now. Let's get on with the show and see what we are going to tackle next.


### Links that help

