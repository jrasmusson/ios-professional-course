# Loss of focus Interaction

In this section we tackle the second set of interactions we need to account for when the user enters their password - loss of focus on the text field.

![](images/0a.png)

Here we want to:

- trigger additional custom validation on each text field (error label)
- check whether that 3 of 4 criteria have been met

![](images/1.png)

## Detecting the loss of focus

Let's start by first detecting when the text field loses focus.

**PasswordTextField**

```swift
// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("foo - textFieldDidEndEditing: \(textField.text)")
    }

    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("foo - textFieldShouldReturn")
        textField.endEditing(true) // resign first responder
        return true
    }
}
```

These are the `UITextField` delegates we need to register for in order to detect when the text field loses focus.

We can test there are working by:

- running the app, entering text, and tapping on the other text field
- typing text in via the keyboard and pressing return

## Dismissing the keyboard with a tap gesture 

It would be nice if our users could more easily dismiss the keyboard by tapping anywhere on the screen.

Let's add a gesture recognizer that resigns whatever is currently the first responder, and dismisses the keyboard with a single tap.

**ViewController**

```swift
setup()
style()
layout()

private func setup() {
    setupDismissKeyboardGesture()
}

private func setupDismissKeyboardGesture() {
    let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
    view.addGestureRecognizer(dismissKeyboardTap)
}
    
@objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
    if recognizer.state == UIGestureRecognizer.State.ended {
        view.endEditing(true) // resign first responder
    }
}
```

Discussion:

- explain what gestures are
- explain how tap gesture works

## Communicating back view protocol-delegate

Let's know send our captured loss of focus text back via the protocol delegate.

### Challenge 🕹

Adds this function to our protocol delegate

**PasswordTextField**

```swift
protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField) // add
}
```

and print out the text entered into our password text field from within our view controller.

Good luck!

### Solution ✅

Add the function.

**PasswordTextField**

```swift
protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField) // add
}
```

Call the delegate when the editting ends. Delete old print statements.

**PasswordTextField**

```swift
// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }

    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // resign first responder
        return true
    }
}
```

Implement and print result in the view controller.

**ViewController**

```swift
func editingDidEnd(_ sender: PasswordTextField) {
    print("foo - editingDidEnd: \(sender.textField.text)")
}
```

![](images/2.png)

Good stuff. At this point we've detected the loss of focus and sent that text back to our view controller. 

## How the validation logic is going to work

![](images/3.png)

Walk people through how this is going to work. 

Demo and explain how:

- this validation logic is about updating the error label and doing the 3 of 4 check
- each text field will have slightly different rules
- we are going to capture those rules in validation function
- that function will be defined as a variable
- and then pass in different functions depending on whether we are setting up the new password text field, or the confirm password text field

## Swift review - functions as types

Explain and demo how functions are actually types in Swift. We can use them to represent variables, and even pass to other functions.







# OLD

## How do you make something reuseable?

Reuse in software is great because it let's you take one thing, and the reuse it in multiple different circumstances.

What we want to do here, is we want to reuse our `PasswordTextField` for two different sitations:

- One set of validation rules for new password
- And another for re-enter password

But how can we do that? How can we make one text field behave one way, and the other another?

There are many different ways we could solve this (protocol-delegate, passing in something through the constructor).

But I want to show you another way you may not have seen before - and that is by passing in a function.

### Passing functions

Passing around functions isn't something we do a lot of in most programming languages. The sytax is often confusing. It can make the code harder to read. 

But in Swift, which is a hybrid between Object-Oriented and functional, functions or closures passing is much more prevalent, and much easier to use.

Let's start with a quick crash course in function passing. And see how this works in Swift.

- Demo how to pass functions in Swift and the syntax that makes this all work.

## Custom validation for our text field

Now that we see how to define and pass closures, let's leverage that and define a `CustomValidation` closure for our `PasswordTextField`.

**PasswordTextField**

```swift
class PasswordTextField: UIView {

    /**
     A function one passes in to do custom validation on the text field.

     - Parameter: textValue: The value of text to validate
     - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
     */
    typealias CustomValidation = ((_ textValue: String?) -> (Bool, String)?)
```

This is an `alias`. And while we haven't talked about these before, this is a really handy way of defining a big long class, structure, or function, in a much more easy to read and understand way.

This alias basically describes our text fields validation type. It says if you ever want to refer to a closure of this type, your can simply type:

- `CustomValidation`, instead of
- `((_ textValue: String?) -> (Bool, String)?)`

which is much harder to read.

So with this type now defined, we can use that to represent a variable.

**PasswordTextField**

```swift
let placeHolderText: String
var customValidation: CustomValidation?
weak var delegate: PasswordTextFieldDelegate?

var text: String? {
    get { return textField.text }
    set { textField.text = newValue }
}
```

That's right. Closures can be represented as variables. And here we are defining an optional one to represent the validation rules for this text field.

This is how we are achieving the reuse. We are defining a type. We are going to let anyone pass in here anything they want. And when we execute it, it is going to return us a `Bool`, along with a `String` representing a possible error message.

Don't worry if this is all still confusing. Stay with me. Shortly you will see how this works.

Next let's define the validate method we are going to call when the text field loses focus.

**PasswordTextField**

```swift
// MARK: - Validation
extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
            let customValidationResult = customValidation(text),
            customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }

    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
```

On the surface this function is very simple. If there is an error in the validation closure, we make visible and show the text on the error. If not we reset and hide.

But there is a lot going on in that if statement. Let's unpack it (discuss).

OK. So with our validation closure now setup and define, all we need now is to use it.

Let's head back over to our view controller. And set that up.

## Adding validation rule for empty text

Because we are going to be doing some setup on these controls I'd first like to define a `setup` method.

**ViewController**

```swift
class ViewController: UIViewController {
    typealias CustomValidation = PasswordTextField.CustomValidation


style()
setup() // add
layout()
```

And then in there I'd like to setup the new text field.

**ViewController**

```swift
func style() { ... }
    
private func setup() {
    setupNewPassword()
}
```

Like this:

```swift
private func setupNewPassword() {
    let newPasswordValidation: CustomValidation = { text in
        
        // Empty text
        guard let text = text, !text.isEmpty else {
            self.statusView.reset()
            return (false, "Enter your password")
        }
        
        
        return (true, "")
    }
    
    newPasswordTextField.customValidation = newPasswordValidation
}
```

What this is doing is setting the custom validation rules for our text field. This may not seem obvious at first but there are multiple validations occurring in the app:

First we have the validations that occur as the user is typing - those update the status view.

Then we have the validations that occur when the users losts focus - those update the status and the error label on the text field.

This validation we just define here in this closure is updating that error field. By returning a tuple (that we defined as part of our closure) we are enabling any component to decide what error to return and when, in a generic reusable way.

In the event that something goes wrong we also want to reset the status view. We can do that like this:

**PasswordStatusView**

```swift
func reset() {
    lengthCriteriaView.reset()
    uppercaseCriteriaView.reset()
    lowerCaseCriteriaView.reset()
    digitCriteriaView.reset()
    specialCharacterCriteriaView.reset()
}
```

Last but not least, we need to trigger this validation by 


If we run this now, we should be able to lose focus, and trigger an error label update in the event the new password text field is blank.



### Challenge 🕹 Adding validation rules for other





