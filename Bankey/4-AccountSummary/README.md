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

Drag out the following and embed in a stack view.

- `logoLabel` - title1, Bankey
- `greetingLabel` - title3, Good morning, 
- `nameLabel` - title3 bold, Jonathan
- `dateLablel` - body

Explain what CHCR means and how to fix.

![](images/2.png)

Bankey.

![](images/3.png)

Drag out an imageView and set to `sun.max.fill`. 

- Embed the label stackview and image in another stack view.
- Set `View` background to `teal`.

Layout as follows:

![](images/4.png)

Should now look like this.

![](images/5.png)

Header looking good. Next let's define a cell for our table view.

Bonus video: Give a demo of Reveal and how to use when checking your layouts for ambiguity.

Save your work.

## Creating the customer table view cell

- Explain what table view cells are
- How they work
- Why iOS is able to scroll so quickly and be so efficient

While we could do this with a nib, let's do this one entirely programmatically so you can see how that would work.

Create a new class in Account Summary called `AccountSummaryCell`.

**AccountSummaryCell**

```swift
import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    
    private func setup() {

    }
    
    private func layout() {
        
    }
}
```

Create image showing layout.

Let's add all the elements then style them one-by-one. Starting with the account `typeLabel`.

```swift
let typeLabel = UILabel()
let underlineView = UIView()
let nameLabel = UILabel()
    
let balanceStackView = UIStackView()
let balanceLabel = UILabel()
let balanceAmountLabel = UILabel()
    
let chevonImageView = UIImageView()

static let reuseID = "AccountSummaryCell"
static let rowHeight: CGFloat = 80

typeLabel.translatesAutoresizingMaskIntoConstraints = false
typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
typeLabel.adjustsFontForContentSizeCategory = true
typeLabel.text = "Account type"

addSubview(typeLabel)

typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
```

Now let's go register and dequeue this cell in our view controller.

**AccountSummaryViewController**

```swift
private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
    
    view = tableView
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return AccountSummaryCell.rowHeight
}
```

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