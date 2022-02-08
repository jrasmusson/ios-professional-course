# Password Inline Interactions

![](images/0.png)

There are two sets of interactions occurring in our password validation view:

1. Inline 
2. Loss of focus

The inline validation is what occurs as the user is typing. This update the individual criteria in the status view as they are typing, and gives them real-time feedback on which criteria they password pass while updating the view.

Loss of focus validation is what occurs when the text field losses focus, and the user wants to do they password validation check on the rules as a group.

Before we can tackle these problems, we are going to need a solid understanding of:

- how `UITextField` works
- something called `responder chain`

Let's review those now.

## Meet the UITextField

- [UITextField](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/UITextField.md)

Challenges:

1. Create new project (with storyboards).
2. Add a stack view with a text field and a label vertically.
3. Update the label with the text field contents as the user types
4. Print out the contents of the text field when they press enter.
5. Dismiss the keyboard.

## Get to know the UIKit Responder Chain

- [Responder Chain](https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/Responder-Chain.md)

### How does communication in UIKit work?

### What does it mean to become firstResponder?

### How does all this relate to UITextField?

OK so at this point you:

- Get the `UITextField`
- Understand `responder chain`
- Already know `protocol-delegate`

We have everything we need to solve our first interaction problem. Let's get in there and apply all this knowledge to our design.

## How the inline interaction works

As the user types, we'll communicate back to our view controller using a protocol-delegate, passing the back the text as they type it in on the keyboard.

![](images/1.png)

This will then result in an update call being made to the status view, in which each individual criteria will update itself, and display either the reset circle image, or the green checkmark (not the red x).

Let's head over to the arcade and set this up 🕹!

## Receiving the just-in-time text

First let's hide the error label.

**PasswordTextField**

```swift
errorLabel.isHidden = true
```

![](images/2.png)

Then let's register ourselves and the text field's protocol-delegate.


**PasswordTextField**

```swift
textField.delegate = self

// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {

}
```

Being the delegate for the text field means implementating the `UITextFieldDelegate` protocol. We don't actually have to do anything. Yet.

Next let's capture the text as the user types by registering a target action on the text field itself.

***PasswordTextField**

```swift
// extra interaction
textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)

extension PasswordTextField {
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        print("foo - \(sender.text)")
    }
}
```

Remember this is the extra interaction we are adding because the text field protocol-delegate doesn't quite give us what we want. But this target action does.

If we run this now, we should see the how word being printed out as we type.

![](images/3.png)

Now that we have the text field hooked up. Let's add our own protocol-delegate for communicating this important information back to our view controller.


## Talking back to the view controller

We can pass the text, as the user types, back to the view controller via the protocol-delegate.

![](images/1.png)

All we need to do is:

- define our protocol
- declare the delegate, and then
- fire the event as the user types

**PasswordTextField**

```swift
protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
}

weak var delegate: PasswordTextFieldDelegate?

extension PasswordTextField {
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self) // add
    }
}
```

And then register ourselves for this callback in our view controller.

**ViewController**

```swift
newPasswordTextField.delegate = self

// MARK: PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            // statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
}
```

Eventually we are going to update our status view from here - passing in the text so the status view can figure out how to update itself.

But we can't do that yet. So let's go set that up now.

## Updating the status view

Updating the status view means checking the criteria of the password being passed it, and seeing which criteria are met.

We have five critera we want out passwords to meet. Let's take them one at a time. Starting with the length of 8-32 characters.

### Length Criteria

We can make the length criteria easy to check, by putting this logic into a dedicated structure that is going to do nothing but checkout our password criteria. Let's call it `PasswordCriteria`.

- Create a new file called `PasswordCritiera`.

**PasswordCriteria**

```swift
struct PasswordCriteria {
    static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
}
```

Putting this logic here, and not in the view itself, makes this logic more testable. Which will aid us later when adding unit tests.

But this actually isn't enough to meet that first criteria. We also need to check and see that there are not spaces, and that both of these criteria are met. Let's add two more criteria and use that to satisfy that first condition.

**PasswordCriteria**

```swift
static func noSpaceCriteriaMet(_ text: String) -> Bool {
    text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
}
    
static func lengthAndNoSpaceMet(_ text: String) -> Bool {
    lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
}
```

Now with these three static functions, we are in a position to determine whether that 8-32 no space criteria is met. But before we apply that logic, let's talk about one strange interaction our UX designers asked us to implement. The Reset.

### The reset

As the user is typing, our UX designers want the password criteria contorl to toggle between:

- ✅ and ⚪️

But not the ❌. Demo.

They only want the ❌ to appear when the text field loses focus, and there on after when they go back and type in the text field.

To handle this UX nuance/capability, we need a way of tracking when the status view would be reset. So to do that, we'll create this variable.

**PasswordStatusView**

```swift
// Used to determine if we reset criteria back to empty state (⚪️).
private var shouldResetCriteria: Bool = true
```

And use it to determine when the text field has lost focus, and when it should reset.

We set it to true initially, because initally when the user starts typing in the control, we always want it to reset (only show ✅ and ⚪️).

But later on, when the text field has lost focus, we will set it to false.

```swift
shouldResetCriteria = false
```

And that's when it should start showing the ❌ too. But for now we are only going to flip between ✅ and ⚪️. Will tackle making ❌ appear later when we lose focus.

So with that explaination, let's how update our view based on the length and space criteria of our password.

**PasswordStatusView**

```swift
let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
...
private var shouldResetCriteria: Bool = true

// MARK: Actions
extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)

        if shouldResetCriteria {
            // Inline validation (✅ or ⚪️)
            lengthAndNoSpaceMet
                ? lengthCriteriaView.isCriteriaMet = true
                : lengthCriteriaView.reset()
        }
    }
}
```

And then comment in the call from our view controller to update the status view state.

**ViewController**

```swift
// MARK: PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
}
```

![](images/4.png)

🎉 Voila! Great stuff. Let's do it again for uppercase.

### Upper case criteria

We can check to see whether any of the letters contain uppercase letters using `regex`.

**PasswordCriteria**

```swift
static func uppercaseMet(_ text: String) -> Bool {
    text.range(of: "[A-Z]+", options: .regularExpression) != nil
}
```

[Regex](https://en.wikipedia.org/wiki/Regular_expression) is pattern matching tool for seaching for pattern of characters in text.

You define the pattern regex expression you'd like to match (i.e. `[A-Z]+` for any uppercase characters). Run it against the text you'd like to parse. And voila - regex will tell you if there is a match.

Just like before, we can then add this check to our view.

**PasswordStatusView**

```swift
let uppercaseMet = PasswordCriteria.uppercaseMet(text)

uppercaseMet
    ? uppercaseCriteriaView.isCriteriaMet = true
    : uppercaseCriteriaView.reset()

uppercaseCriteriaView.isCriteriaMet = uppercaseMet
```

If we run then, we just now see our uppercase check in play.

![](images/5.png)

### Challenge 🕹 Adding lowercase and digit check

OK. Doing the same thing we did for uppercase, see if you can add the lower case and digit checks.

Add two functions to `PasswordCriteria`:

```swift
static func lowercaseMet(_ text: String) -> Bool {
    text.range(of: "ANY LOWERCASE REGEX", options: .regularExpression) != nil
}

static func digitMet(_ text: String) -> Bool {
    text.range(of: "ANY DIGIT REGEX", options: .regularExpression) != nil
}
```

Given them each their respective regex expressions:

- lowercase: `[a-z]+`
- digit: `[0-9]+`

Any then leverage these in `PasswordStatusView` following the same pattern as before with `lengthAndNoSpaceMet` and `uppercaseMet`.

Good luck!

### Solution ✅

**PasswordCriteria**

```swift
static func lowercaseMet(_ text: String) -> Bool {
    text.range(of: "[a-z]+", options: .regularExpression) != nil
}

static func digitMet(_ text: String) -> Bool {
    text.range(of: "[0-9]+", options: .regularExpression) != nil
}
```

**PasswordStatusView**

```swift
let lowercaseMet = PasswordCriteria.lowercaseMet(text)
let digitMet = PasswordCriteria.digitMet(text)

lowercaseMet
    ? lowerCaseCriteriaView.isCriteriaMet = true
    : lowerCaseCriteriaView.reset()

digitMet
    ? digitCriteriaView.isCriteriaMet = true
    : digitCriteriaView.reset()
    
lowerCaseCriteriaView.isCriteriaMet = lowercaseMet
digitCriteriaView.isCriteriaMet = digitMet
```

If we run this now, we should now see a lowercase and digit check.

![](images/6.png)

### Checking for special characters

Our last password check is one for special characters. The only special characters we want to allow are:

`@:?!()$#,.\/`

This one is tricky because:

1. We need to escape certain characters for Swift (i.e. `/`).
2. We need to special format the regex expression to search for the chars we want.
3. 
To debug this I found it handy to create a Swift playground, and do some manually testing in there. Let's do that now.

- Create a new Swift playground
- Save on desk top
- Copy in the following code

**Playground**

```swift
let text = "@"
let specialCharacterRegex = "[@]+"
text.range(of: specialCharacterRegex, options: .regularExpression) != nil
```

The way regex special characters work is we insert whatever special char we want to look for in these brackets:

- `[special chars here]+`

And then one at a time, we can test to see that they work by running the playground

- once with the special char

![](images/8.png)

- once without

![](images/7.png)

### Challenge 🕹

See how many of these special characters you can get to work in the playground:

- `@:?!()$#,./`

Keep adding the above characters one at a time to our regex expresssion

```swift
let specialCharacterRegex = "[@...]+" 
```

See how many you can get to pass. You get one point for every character you can add.

Good luck!

### Solution ✅

If we continue the pattern above these characters are fairly easy to add. For everyone one of these you got, give yourself a point 🕹.

```swift
let text = "."
let specialCharacterRegex = "[@:?!()$#,.]+"
text.range(of: specialCharacterRegex, options: .regularExpression) != nil
```

It's the brackets that are tricky.

Swift has [special characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#:~:text=The%20escaped%20special%20characters%20%5C0,and%20%5C'%20(single%20quotation%20mark)) in strings that we need to treat differently. 

For example you can't just enter a back slash into a Swift string. We need to escape it.

```swift
"\" // 💥 compile error
"\\" // ✅ escaped
```

So that's the first challenge we need to understand and overcome. We need to escape `\\ backslashes` when adding to String in Swift.

The second challenge is then doing the same thing back for regex. Regex has [certain characters](https://stackoverflow.com/questions/399078/what-special-characters-must-be-escaped-in-regular-expressions) that need to be escaped.

For example to detect a forward slash in regex we need to escape it like this:

```swift
let text = "/"
let specialCharacterRegex = "[@:?!()$#,.\\/]+"
text.range(of: specialCharacterRegex, options: .regularExpression) != nil
```

Then finally the last character we need to handle is the back slash. Which we can escape in regex as follows (4 slashes):

```swift
let text = "\\"
let specialCharacterRegex = "[@:?!()$#,.\\/\\\\]+"
text.range(of: specialCharacterRegex, options: .regularExpression) != nil
```

So bringing it all together we can now define a special character check like this:

**PasswordCriteria**

```swift
static func specialCharacterMet(_ text: String) -> Bool {
    // regex escaped @:?!()$#,.\/
    return text.range(of: "[@:?!()$#,.\\/\\\\]+", options: .regularExpression) != nil
}
```

And check for it like this:

**PasswordStatusView**

```swift
let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
    
specialCharacterMet
    ? specialCharacterCriteriaView.isCriteriaMet = true
    : specialCharacterCriteriaView.reset()
```

![](images/9.png)

And if we try all our special characters out, we should now be able to detect each and every case.

![](images/10.png)

### Save your work 💾

```
> git add .
> git commit -m "feat: add inline interactions"
```

