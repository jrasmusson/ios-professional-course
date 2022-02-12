# Lost focus Interactions

In this section we tackle the second set of interactions we need to account for when the user enters their password - loss of focus on the text field.

![](images/0.png)

Here we want to:

- trigger additional custom validation on each text field
- check whether that 3 of 4 criteria have been met

![](images/1.png)

And we wanto to do all this in a way that let's us:

- reuse the same text field  for both password components
- makes it easy to unit test after

Let's start by adding the custom validation on the text fields, and then deal with the 3 of 4 criteria check after.

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





