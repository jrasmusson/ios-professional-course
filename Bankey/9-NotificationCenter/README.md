# Notification Center

Sometimes you need to send messages far and wide in your app. And `NoficiationCenter` is a way to do that. In this section we are going to use `NotificationCenter` to help us with logout.

Let's start by adding a logout button to our `AccountSummaryViewController` screen, and see why sending that message back to our `AppDelegate` is harder than it looks.

## Adding a logout button

First let's add the logout button to our `AccountSummaryViewController`.

**AccountSummaryViewController**

```swift
lazy var logoutBarButtonItem: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    barButtonItem.tintColor = .label
    return barButtonItem
}()

extension AccountSummaryViewController {
    private func setup() {
        setupNavigationBar()

    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        
    }
}
```

If we run this logout button should now appear.

Discussion:

- Note how `label` is a color
- Explain `lazy var` - a different way of initializing controls

![](images/0.png)

If we click on the button, it won't do anything. That's because we haven't yet hooked it up to our protocol-delegate.

Now this leads to an interesting question. How do we send logout as a message back to the `AppDelegate`?

If we look at our view hierarchy we can see we've got a pretty long way to go if we wanted to use `protocol-delegate`.

![](images/1.png)

AppDelegate > MainViewController > AccountSummaryViewController

Better option here would be another communication pattern - `NotificationCenter`.

![](images/2.png)

## Hooking up Notification Center

U R HERE

### Adding a launch screen

Add a launch screen image.

- Open `LaunchScreen.storyboard`.
- Add a `UIImageView` with image `banknote.fill`.
- Give width `240 pt`
- Give height `142 pt`
- Center

### Links that help

