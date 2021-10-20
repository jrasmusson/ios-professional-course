# Container View Controllers

- Intro: Demo where we are headed.
- To get there however we first need to understand the role of Container View Controllers in iOS.
- Let's start by reviewing:
 - What they are
 - How they work
 - And then see how we can build them ourselves.
 
## What are Container View Controllers


- Container view controllers are view controllers that combine content from child view controllers into a single working interface.

- If you have every used the `General` `UINavigationViewController` works.
- If you have ever ordered a coffee from Starbucks, watched a show on Netflix, or listened to some music on Spotify, you've see the `UITabBarViewController`.
- And if you've every been onboard in a new app, you've seen the `UIPageViewController`.
- These are all Container View Controllers.

  - UINavigationController
  - UITabBarController
  - UIPageViewController
  - Custom container controllers we ourselves make

- And then all do the same thing. They take in child view controllers, and then handle how they're displayed.

For our app, we are going to use a `UITabBarController`. Which means we need to pass in all the VCs we want managed, and then let it figure out which one to display.

Let's head over to the arcade and set this up now.

## Adding the TabBarController

### Links that help

- [Implementing a Container View Controller](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/)
- [Creating a Custom Container View Controller](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller)

# Scrollable View Controllers
 - What are how they work
 - UIScollView
 - UICollectionView
 - UITableView 

Adding the table view

