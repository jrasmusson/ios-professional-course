# Animation

- What is iOS animation?
- How does it work?

## Animating with constraints

- Animate the buttons when user transitions to login

### Setup

**AppDelegate**

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
                
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
//        let vc = loginViewController
//        let vc = mainViewController
        let vc = onboardingViewController
        
//        vc.setStatusBar()
//
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        
        return true
    }
```

Get rid of purple background

**OnboardingContainerViewController**

```swift
private func setup() {
    view.backgroundColor = .systemPurple
``` 

Add a launch screen image.

- Open `LaunchScreen.storyboard`.
- Add a `UIImageView` with image `banknote.fill`.
- Give width `240 pt`
- Give height `142 pt`
- Center

Switch to iPod touch simulator to better see animations.

Show debug slow animation feature.

Save your work.

```
> git add -p
> git commit -m "feat: Add launch screen"
```

### Capturing the constraints

In order to animation with auto layout constraints we need to get our hands on the constraints we'd like to animate.



## Animating with Core Animation

- What is Core Animation (CA)
- How does it work?

### Links that help

