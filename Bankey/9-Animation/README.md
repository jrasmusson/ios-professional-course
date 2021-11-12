# Animation

- What is iOS animation?
- How does it work?

## Animating with constraints

- Animate the buttons when user transitions to login

### Setup


Switch to iPod touch simulator to better see animations.

Show debug slow animation feature.

Save your work.

```
> git add -p
> git commit -m "feat: Add launch screen"
```

### Capturing the constraints

In order to animation with auto layout constraints we need to get our hands on the constraints we'd like to animate.

Let's start by animating the close button off the top.

**OnboardingContainerViewController**

```swift
// animation anchors
var closeTopAnchor: NSLayoutConstraint?

// Close
NSLayoutConstraint.activate([
    closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
])
    
closeTopAnchor = closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
closeTopAnchor?.isActive = true
```

And let's create a new extension that will set our buttons on/off screen via their constraints.

```swift
// MARK: Animations
extension OnboardingContainerViewController {
    private func resetAnimationConstraintsOnScreen() {
        closeTopAnchor?.constant = 16
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setAnimationConstraintsOffScreen() {
        closeTopAnchor?.constant = -80
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
```

We will want to trigger these when the `Done` button is pushed

```swift
// MARK: Actions
extension OnboardingContainerViewController {
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
        setAnimationConstraintsOffScreen()
    }
}
```

 and reset them everytime we go back or reload a previous onboarding screen.

```swift
// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        resetAnimationConstraintsOnScreen()
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        resetAnimationConstraintsOnScreen()
    }
}
```

For testing let's temporarilty display our onboarding vc again when done pressed.

**AppDelegate**

```swift
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
//        setRootViewController(mainViewController)
        setRootViewController(onboardingViewController)
    }
}
```

If we run this now we should see our `Close` button animate up when we click done, and animate back in when the page is reloaded.

Demo.

### Challenge: Animate away the `Next` and `Done` buttons.

See if you can animate away the `Next` and `Done` button just like we did for close.

Create two new constraints to capture the bottom anchor of each button.

```swift
var backBottomAnchor: NSLayoutConstraint?
var doneButtomTopAnchor: NSLayoutConstraint?
```

- Capture them in layout.
- Then set their `constant` values when the appear on/off screen just like we did for close, only going on the other direction. Make them animate off the bottom.

### Solution

Let's add the new constraints.

```swift
var backBottomAnchor: NSLayoutConstraint?
var doneButtomTopAnchor: NSLayoutConstraint?
```


Not bad. Just one little problem. The button visibility we are setting on `currentVC` is interfering with the animation.

Because the animation is now handling the button visibility, we no longer need it. Update `currentVC` computed property as follows:

```swift

```

## Animating with Core Animation

- What is Core Animation (CA)
- How does it work?

### Links that help

