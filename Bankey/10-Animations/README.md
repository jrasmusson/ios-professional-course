# Animations


## Animating with constraints

- image 
- explain how it works

First define some variables to represent the edges of our constraints.

```swift
weak var delegate: LoginViewControllerDelegate?
    
// animation
var leadingEdgeOnScreen: CGFloat = 16
var leadingEdgeOffScreen: CGFloat = -1000
```

Then modify the `titleLabel` constraints so that we can get our hands on the constraint as a variable. Note how we set its initial value to offscreen.

```swift
// Title
NSLayoutConstraint.activate([
    subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
    titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
])
    
titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
titleLeadingAnchor?.isActive = true
```

Then let's create an extension to hold all our animation logic.

```swift
// MARK: - Animations
extension LoginViewController {
    private func setAnimationsOnScreen() {
        titleLeadingAnchor?.constant = leadingEdgeOnScreen
    }
    
    private func resetAnimationsOfScreen() {
        titleLeadingAnchor?.constant = leadingEdgeOffScreen
    }
    
    private func animate() {
        let titleAnimation = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }
        titleAnimation.startAnimation()
    }
}
```

Run the app now. And you should see the title appear offscreen.

Now comes the fun part. Animating the title in. To do this we need to hook into the `viewDidAppear` lifecycle of the view controller. We want the auto layout to have fully completed. Now we want to change the constraint and trigger the animation in.

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setAnimationsOnScreen()
    animate()
}
```

What makes this all work is this line here:

```swift
let titleAnimation = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
    self.view.layoutIfNeeded()
}
```

This is a signal to layout the subview immediately if any values have changed. Which they have.

If we run this now, we should see the title label animate in.

Let's save our work.

```
> git add -p
> git commit -m "feat: Animate in login title label"
```

## Challenge - Animate in the sub title

OK your turn. Following the step we just did for title, see if you can animate in the `subtitleLabel`.