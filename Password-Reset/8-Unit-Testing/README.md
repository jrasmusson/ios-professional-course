# ✅ Unit Testing

When it comes to unit testing, it's always good to start at the bottom (and test the most detailed things there) and then work your way up to the top, testing different conditions as you go.

Let's start by testing some boundary conditions on `PasswordCriteria` and work our way up from there

## 🕹 Challenge

- Create a new test file: `PasswordCriteriaTests`

Add write some boundary condition checks for the password 8-32 length criteria.

Here is the first test to get you going. Take a stab at filling in the others.

**PasswordCriteriaTests**

```swift
import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {

    // Boundary conditions 8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        // 🕹
	}
    
    func testValidShort() throws {
        // 🕹
    }

    func testValidLong() throws {
        // 🕹
    }
}
```

Movie poster to prevent you from just looking at the answer 😉.

![](images/war.jpg)

## ✅ Solution

**PasswordCriteriaTests**

```swift
func testLong() throws {
    XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123"))
}
    
func testValidShort() throws {
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
}

func testValidLong() throws {
    XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012"))
}
```

## Password criteria tests

Something else we could test here is all the other criteria that need to be met:

- no spaces

Here are some tests for spaces

**PasswordCriteriaTests**

```swift
class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
}
```

## 🕹 Challenge

Why don't you see if you can write some more for the other criteria we need to check for:

- lengthAndNoSpaceMet
- uppercaseMet
- lowercaseMet
- digitMet
- specialCharacterMet

Come up with your own naming convention. Think about how many permutations you want to check for in each test. And just practice writing unit tests for various scenarions like the ones above.

Good luck 🚀!

![](images/raiders.jpg)

**PasswordCriteriaTests**

```swift
class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }

    func testLengthAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345678"))
    }

    func testLengthAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1234567 8"))
    }
    
    func testUpperCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
    }

    func testUpperCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
    }

    func testLowerCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
    }

    func testLowerCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
    }

    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("1"))
    }

    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("a"))
    }
    
    func testSpecicalCharMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("@"))
    }

    func testSpecicalCharNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("a"))
    }
}
```

Discussion:

- No one way to do this. You could group multiple tests together.
- Or your could write one test per condition
- I do both depending on how I feel 
- What I really shoot for is readability
- Try to make your tests as readable as possible

## Adding context

To avoid making your unit tests to convoluted or trying to test too many things, break tests up according to their specific test condition or their context.

- Create a new file `PasswordStatusViewTests`

For example let's say we want to test that only ✅ or ⚪️ are displayed in the status view when the user is doing in line validation.

To capture this context, create a specific test class describing the specific context you are trying to test.

**PasswordStatusViewTests**

```swift
import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
    }
}
```

Add these following helpers to aid us in our tests:

**PasswordStatusView**

```swift
// MARK: Tests
extension PasswordCriteriaView {
    var isCheckMarkImage: Bool {
        return imageView.image == checkmarkImage
    }

    var isXmarkImage: Bool {
        return imageView.image == xmarkImage
    }

    var isResetImage: Bool {
        return imageView.image == circleImage
    }
}
```

The advantages of doing this are numersou:

1. You make the test clear.
2. You keep it simple.
3. It requires less setup.
4. It's easier to follow.


## 🕹 Challenge 

Now you try. See if you can write the converse of the above, and test the loss of focus mode where a status view should only flip between: a

- checkmark ✅, and a
- red X ❌

when `shouldResetCriteria = false`.

**PasswordStatusViewTests**

```swift
class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = ??? // loss of focus
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        // 🕹 Ready Player1
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        // 🕹 Ready Player1
    }
}
```

![](images/empire.jpg)

## ✅ Solution

There is no one way to do this. So don't worry if you came up with something different.

But here is a new set of test cases for this specific context.

**PasswordStatusViewTests**

```swift
class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage) // ❌
    }
}
```

## Unit testing the three of four critiera

How do you think we should unit test this?

**PasswordStatusView**

```swift
func validate(_ text: String) -> Bool {
    let uppercaseMet = PasswordCriteria.uppercaseMet(text)
    let lowercaseMet = PasswordCriteria.lowercaseMet(text)
    let digitMet = PasswordCriteria.digitMet(text)
    let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)

    // Ready Player1 🕹
    let checkable = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
    let metCriteria = checkable.filter { $0 }
    let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
    
    if lengthAndNoSpaceMet && metCriteria.count >= 3 {
        return true
    }

    return false
}
```

## 🕹 Challenge

See if you can come up with the unit tests for the `PasswordStatusView` three of four check:

Figure out:

- what a good set of unit tests would be
- what to name the test class
- how to organize the tests
- how to test this logic

Do this work in the existing `PasswordStatusViewTests` class. Call and name these set of tests whatever you want.

Good luck 🚀!

![](images/star.jpg)

## ✅ Solution

Lots of ways you could do this. Here is one.

**PasswordStatusViewTests**

```swift
class PasswordStatusViewTests_Validate_Three_of_Four: XCTestCase {

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
```

Discussion:

- Note the class name (good context)
- Clearly defined well named variables
- Want to make test very clear
- Doesn't need to be complicated

## View Controller Tests

Here at the higher level we want to verify things are connected and properly hooked together. This would be a good place to test:

- Error messages properly get set
- Alert gets shown

## How to test error messages

### Next text field

Let's start by testing that `Enter your password` gets displayed when a user taps the reset button with an empty text field.

- Create a new file `ViewControllerTests`


**ViewControllerTests**

```swift
import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }

    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
    }
}
```

Helpers for our unit tests.

**ViewController**

```swift
// MARK: Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue}
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue}
    }
}
```
 
Discussion:
 
 - Exposing access to new password text
 - Triggering reset button tap
 - Confirming text is set

## 🕹 Challenge
 
See if you can write the other equivalent test cases for:
 
**ViewControllerTests**
 
```swift
func testInvalidPassword() throws {
    // 🕹
}

func testCriteriaNotMet() throws {
    // 🕹
}

func testValidPassword() throws {
    // 🕹
}
```

Good luck 🚀!

![](images/alien.jpg)
 
## ✅ Solution
 
**ViewControllerTests**
 
```swift
func testInvalidPassword() throws {
    vc.newPasswordText = "🕹"
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
}

func testCriteriaNotMet() throws {
    vc.newPasswordText = tooShort
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Your password must meet the requirements below")
}

func testValidPassword() throws {
    vc.newPasswordText = validPassword
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "")
}
```

### Confirm text field

Let's now do the same thing for the confirm text field. Let's start like we did before, by testing empty password.

**ViewControllerTests**

```swift
class ViewControllerTests_Confirm_Password_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password.")
    }
}
```

## 🕹 Challenge

See if you can write the other test cases for:

- passwords do not match - `Passwords do not match.`
- passwords match - No error message

Movie poster to prevent you from just scrolling down and looking at the answer 😉.

![](images/tron.jpg)


## ✅ Solution

**ViewControllerTests**

```swift
func testPasswordsDoNotMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = tooShort
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match.")
}

func testPasswordsMatch() throws {
    vc.newPasswordText = validPassword
    vc.confirmPasswordText = validPassword
    vc.resetPasswordButtonTapped(sender: UIButton())
    
    XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
}
```

## How to test alerts

Alerts have titles and messages. If we could get our hands on the alert, we could check it for it's presense and title.

Let's start by adding an optional variable for the alert so we can get our hands on it, and then test for its presense to see if it ever gets displayed.

**ViewController**

```swift
var alert: UIAlertController?

private func showAlert(title: String, message: String) {
    alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
    guard let alert = alert else { return }

	...
}
```

**ViewControllerTests**

```swift
class ViewControllerTests_Show_Alert: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success") // Optional
    }

    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNil(vc.alert)
    }
}
```

Discussion:

- tests and coupling
- talk about whether to include the `Success` text check
- the pros and cons

## 💾 Save your work

```
> git add .
> git commit -m "test: add unit tests for password reset"
```

Good stuff 🎉






