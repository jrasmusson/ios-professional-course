# Protocol-Delegate

- In this section you are going to learn not only learn what protocol-delegate is and how it works
 - you are also going to see how we can leverage its power ourselves when building UIKit applications
- We will start by first reviewing what the protocol-delegate is and how it works, then we'll shift gears and use it in our app for handling signin and onboarding

Youtube video.
 
 1. Login
 2. Onboarding

OK, so now that you've seen how protocol-delegate works, let's head over to the arcade, and see how we can use itto signal to our `AppDelegate` that login and onboarding are done, and then ultimately aid us in our navigation.
 
## Protocol-Delegate Login

First lets define the protocol and delegate.

**LoginViewController**

```swift
protocol LoginViewControllerDelegate: AnyObject {
//    func didLogin(_ sender: LoginViewController) //  in you need to pass data back
    func didLogin()
}

weak var delegate: LoginViewControllerDelegate?
```

- Discuss alternative naming conventions.

Then let's use it in `AppDelgate` to signal login was complete and successful.

**AppDelegate**

```swift
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        // Display home screen
        print("foo - Did login")
    }
}
```

- Discuss `foo` in print statement.

Need to keep our view controllers around so we can register ourselves as the delegate.

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    let loginViewController = LoginViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        loginViewController.delegate = self
        
        window?.rootViewController = loginViewController
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        // Display home screen
        print("foo - Did login")
    }
}
```

- Test it out. 
- Should now see print statement.
- Discuss how to filter print statements.
- Except it doesn't work. Because we forget to call it.

**LoginViewController**

```swift
if username == "" && password == "" {
    signInButton.configuration?.showsActivityIndicator = true
    delegate?.didLogin()
```

Run again. Now should see print statement.


## Protocol-Delegate Onboarding
 
 Boss challenge - not you add it to onboarding.
 
 ## Bringing it all together in app delegate
 
## Onboard only once

### Links that help


