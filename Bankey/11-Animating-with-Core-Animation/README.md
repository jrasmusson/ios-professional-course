# Animating with Core Animation

- Core Animation Intro.
- Key concepts.

While you can go deep with Core Animation, you don't have to become an expert in bezier curves to get some really cool effects.

Let's know go back to our project and see how we can bright things up by adding some cool Core Animations to our project.


## Shaking the login button

Let's make it so that when the user enters an incorrect password, the login button shakes.

Set our username and password.

**LoginViewController**

```swift
// Check for blanks
if username.isEmpty || password.isEmpty {
    configureView(withMessage: "Username / password cannot be blank")
    return
}
    
if username == "Flynn" && password == "Welcome" {
    signInButton.configuration?.showsActivityIndicator = true
    delegate?.didLogin()
} else {
    configureView(withMessage: "Incorrect username / password")
}
```

Shake the login button is username/password is wrong.

**LoginViewController**

```swift
private func configureView(withMessage message: String) {
    errorMessageLabel.isHidden = false
    errorMessageLabel.text = message
    shakeButton()
}
    
private func shakeButton() {
    let animation = CAKeyframeAnimation()
    animation.keyPath = "position.x"
    animation.values = [0, 10, -10, 10, 0]
    animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
    animation.duration = 0.4

    animation.isAdditive = true
    signInButton.layer.add(animation, forKey: "shake")
}
```

## Shakey Bell

Let's add a bell that shakes everytime someone taps on it while also displaying a count for notifications.


### Links that help

- [Intro to Core Graphics](https://github.com/jrasmusson/swift-arcade/blob/master/Animation/CoreGraphicsIntro/README.md)
- [Intro to Core Animation](https://github.com/jrasmusson/swift-arcade/blob/master/Animation/CoreAnimation/Intro/README.md)

