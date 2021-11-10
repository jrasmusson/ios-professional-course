# Unit Testing

- Show how to add unit tests to existing project
- Talk about code that is suitable for unit testing
 - Anything with logic we can extract out and test as a small indiviudal unit

## CurrencyFormatter

```swift
class CurrencyFormatterTests: XCTestCase {
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

```
> git add .
> git commit -m "test: Add unit tests for currency and date"
```

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

- [What is an Xcode Target?](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Targets.html#:~:text=A%20target%20specifies%20a%20product,in%20a%20project%20or%20workspace.&text=The%20instructions%20for%20building%20a,in%20the%20Xcode%20project%20editor.)
- [Working with Targets](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/WorkingwithTargets.html)