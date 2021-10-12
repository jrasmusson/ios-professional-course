# Account Summary

- image of app navigation


## Discussion of which control to use

### ScrollView

- good for static fixed views
- not good if your data needs to reload

### CollectionView

- good
- little more complex
- sometimes overkill

### TableView

- the work horse of UIKit
- can do just about anything
- will use later

We are going to go with `UITableView`. 

- Its the most commonly used control out there.
- It can do everything you'll ever need.



## Setup

- create branch `account-summary`.
- explain what branches are how they work

## Account Summary View Controller

- demo the page
- explain how it is laid out
- demo some of they affordances (collapable title)
- start building it

## Adding the tab bar

**MainViewController**

```swift
import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let summaryVC = AccountSummaryViewController()
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")

        let moveMoneyVC = MoveMoneyViewController()
        moveMoneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")

        let moreVC = MoreViewController()
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")

        let tabBarList = [summaryVC, moveMoneyVC, moreVC]

        viewControllers = tabBarList
    }
}

class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray5
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGray4
    }
}

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
```

Delete `DummyViewController`. Add `MainViewController`.

**AppDelegate**

```swift
let mainViewController = MainViewController()
setRootViewController(mainViewController) // x2
```

## Creating Account Summary View Controller

- UITableView with custom cell and header
- Create directory `AccountSummary`
- Extract into own class


Let's start with an empty table view controller with some basic data.

**AccountSummaryViewController**

```swift
import UIKit

class AccountSummaryViewController: UIViewController {
    
    let games = [
        "Pacman",
        "Space Invaders",
        "Space Patrol",
    ]
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view = tableView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
```

Discussion:

- simplest table we can start with
- explain how table layout is done here
- remind people how table view works

![](images/0.png)

Next let's add the header.

### Adding the table view header

- There is lots of confusion around how to add a table view header ([link](https://stackoverflow.com/questions/16471846/is-it-possible-to-use-autolayout-with-uitableviews-tableheaderview))
- The simplest, most reliable way is to create a complex, autolayout header is to:
 - Create a nib 
 - Add it as a `tableHeaderView` to the table.

#### Create a class

- Create a class `AccountSummaryHeaderView`

**AccountSummaryHeaderView**

```swift
import UIKit

class AccountSummaryHeaderView: UIView {

}
```

#### Create a nib

- Create a nib view named `AccountSummaryHeaderView`
- Set to height `200`
- Set `File's Owner` to `AccountSummaryHeaderView`
- Give the nib a red background
- Drag `view` from nib into file and call `contentView`.
- Then load the nib and pin to the edges like this
 
**AccountSummaryHeaderView**

```swift
import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
}
```

- Add it to the table.


```swift
setupTableHeaderView()

private func setupTableHeaderView() {
    let header = AccountSummaryHeaderView(frame: .zero)
    
    var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    size.width = UIScreen.main.bounds.width
    header.frame.size = size
    
    tableView.tableHeaderView = header
}        
```

![](images/1.png)

### Styling the header

- Now because we have a nib, we can do all our auto layout in there.
- Set background back to `System Background Color`.

Drag out the following labels vertically with the following font sizes:

- `logoLabel` - title1, Bankey
- `greetingLabel` - title3, Good morning, 
- `nameLabel` - title3 bold, Jonathan
- `dateLablel` - body

Set `View` background to `systemPurple`.

Embed in a stackview and layout as follows:

![](images/4.png)

Explain what CHCR means and how to fix.

![](images/2.png)

Bankey.

![](images/3.png)

Should now look like this.

![](images/5.png)

U R HERE




- Enable bolding

**UIFont+Traits**

```swift
import Foundation
import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
}
```

```swift
//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-11.
//

import Foundation
import UIKit

class AccountSummaryHeaderView: UIView {
    
    let stackView = UIStackView()
    
    let logoLabel = UILabel()
    let greetingLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension AccountSummaryHeaderView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        logoLabel.adjustsFontForContentSizeCategory = true
        logoLabel.text = "Bankey"

        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        greetingLabel.adjustsFontForContentSizeCategory = true
        greetingLabel.text = "Good morning,"

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.text = "Jonathan"

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.adjustsFontForContentSizeCategory = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = formatter.string(from: Date())
    }
    
    func layout() {
        stackView.addArrangedSubview(logoLabel)
        stackView.addArrangedSubview(greetingLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
```

![](images/1.png)

Discussion

- Why is `Bankey` more spaced to top?
- That's how Stack Views work. They stretch to fill.

Couple ways we can fix:

 - modify intrinisc content size
 - give a fixed constraint / height for header view
 - or leave it if we think it looks good

Save your work

### Creating the scroll view

- Scroll views are...
- And the way they work is...
- The trick with scroll views is understanding that there are x2 sets of constraints and then everything needs a height.

Lets start by:

- Creating a tile view
- Adding our scroll and stack view
- Adding our tiles to the stack.

#### Creating the tile view

**AccountSummaryTile**

```swift
import Foundation
import UIKit

class AccountSummaryTile: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 100)
    }
}

extension AccountSummaryTile {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
    }
}
```

#### Adding the tile to the view controller

**AccountSummaryViewController**

```swift
let scrollView = UIScrollView()
let stackView = UIStackView()

let tiles = [
    AccountSummaryTile(),
    AccountSummaryTile(),
    AccountSummaryTile(),
    AccountSummaryTile(),
    AccountSummaryTile()
]

scrollView.translatesAutoresizingMaskIntoConstraints = false

stackView.translatesAutoresizingMaskIntoConstraints = false
stackView.axis = .vertical
stackView.spacing = 8

for tile in tiles {
    stackView.addArrangedSubview(tile)
}

// Scroll + StackView
NSLayoutConstraint.activate([
    scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    
    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
    stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
    stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
    
    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
])
```

![](images/3.png)

- Save your work

#### Creating a generic tile

Let's create a generic tile that can display all our various bits of information.

- first lets analyze what we need
- then lets build it out full
- then we will define a type (an `enum`) that will tell us what to display and what not to
- then we'll fill it in with some realistic looking data

Adding the `typeLabel`.

**AccountSummaryTile**

```swift
let typeLabel = UILabel()

typeLabel.translatesAutoresizingMaskIntoConstraints = false
typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
typeLabel.adjustsFontForContentSizeCategory = true
typeLabel.text = "Account type"

addSubview(typeLabel)
    
NSLayoutConstraint.activate([
    typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
    typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
])
```

![](images/4.png)

Adding the `underlineView`.

```swift
let underlineView = UIView()

underlineView.translatesAutoresizingMaskIntoConstraints = false
underlineView.backgroundColor = .systemPurple

underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
underlineView.widthAnchor.constraint(equalToConstant: 40),
underlineView.heightAnchor.constraint(equalToConstant: 4)
```

![](images/5.png)

Add `nameLabel` - challenge!

- See if you can add the `nameLabel`.
- Give it a font of `.headline`.
- Placeholder text of `Account name`.
- The put it a spacing of `2` multiplier beneath the underline view
- And leading anchor of `1` from the edge.
- Good luck!

```swift
let nameLabel = UILabel()

nameLabel.translatesAutoresizingMaskIntoConstraints = false
nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
nameLabel.text = "Account name"

addSubview(nameLabel)

nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
```

![](images/6.png)

Adding the balances. Let's try these out in a stack view.

```swift
let balanceStackView = UIStackView()
let balanceLabel = UILabel()
let balanceAmountLabel = UILabel()

balanceStackView.translatesAutoresizingMaskIntoConstraints = false
balanceStackView.axis = .vertical
balanceStackView.spacing = 0
    
balanceLabel.translatesAutoresizingMaskIntoConstraints = false
balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
balanceLabel.text = "Some balance"

balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
balanceAmountLabel.font = UIFont.preferredFont(forTextStyle: .body)
balanceAmountLabel.text = "$100,000.00"

balanceStackView.addArrangedSubview(balanceLabel)
balanceStackView.addArrangedSubview(balanceAmountLabel)
    
addSubview(balanceStackView)

balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
```

Discussion:

- when to stack view and when to not

- Save your work

![](images/7.png)

Now we just need the chevron.

```swift
let chevonImageView = UIImageView()

chevonImageView.translatesAutoresizingMaskIntoConstraints = false
chevonImageView.image = UIImage(systemName: "chevron.right")

addSubview(chevonImageView)

chevonImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
trailingAnchor.constraint(equalToSystemSpacingAfter: chevonImageView.trailingAnchor, multiplier: 1)
```

![](images/8.png)

#### How to make fancy titles

```swift
extension AccountSummaryTile {
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "100,000", cents: "00")
```

![](images/9.png)

### Making the tile dynamic

Now this is nice, but what would be really nice is if we could re-use this account tile view for different types of accounts.

Turns out we can. We just need to give it a way to determine what account type to display, and then give it the neccessary details.

Enums are really good for this. Let's start by defining an account type, and then seeing what data we need to vary.

Discussion

- enums
- ViewModel
- passing in data via the viewModel

**AccountSummaryTile**

```swift
enum AccountType: String {
    case Banking
    case CreditCards
    case Investments
}
    
struct ViewModel {
    let accountType: AccountType
    let accountName: String
    let balanceTitle: String
    let balanceAmount: Decimal
}
```

Now we need to update creating the tiles. Let's pretend we got these over the network.

**AccountSummaryViewController**

```swift
var tiles: [AccountSummaryTile]()
```    


### Selecting a tile

- Next up account summary detail


### Links that help

- [Container Views](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)
- [Table Headers & Footer](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/adding_headers_and_footers_to_table_sections)