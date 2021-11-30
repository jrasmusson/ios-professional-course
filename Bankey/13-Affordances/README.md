# Affordances

## Dispatch Group

It's hard to see, but sometimes parts of our app can load before others leading to a jarring `tableView.reload` experience. That, and because calling `tableView.reload` twice isn't very optimal, it would be nice if there was a way to only refresh the `tableView` once all the data has been fetched.

![](images/0.png)

Fortunately there is. It's called `DispatchGroup`. And it works like this.

## What are DispatchGroups

![](images/1.png)

- How do they work?

### Adding to Bankey

![](images/2.png)

**AccountSummaryViewController**

```swift
// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        let group = DispatchGroup()

        group.enter()
        fetchProfile(forUserId: "1") { result in
			group.leave()
        }

        group.enter()
        fetchAccounts(forUserId: "1") { result in
			group.leave()
        }

        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
```

### Save our work

```
> git add -p
> git commit -m "feat: Group account summary network calls together"
```

Demo. No noticable change. But it does smoooth out the loading our our `tableView` while also giving us one convenient place to react whenever network calls complete.

Which is super handy for pull to refresh.


## Pull to refresh

Pull to refresh is a feature a lot of mobile apps have where you can pull down on the app screen, and have all the data refresh.

- Gmail
- YouTube
- Starbucks

A lot of major apps have it. But we can have it too. And it's really easy to add now that we've grouped our network calls together.


This is a control you can attach to any `UIScrollView`, including table views and collection views. It gives your users a standard way to refresh their contents. When the user drags the top of the scrollable content area downward, the scroll view reveals the refresh control, begings animating its progress indicator, and notifies your app. Use that notification to update your content and dismiss the refresh control.

Let's add one to our account summary view.

**AccountSummaryViewController**

```swift
// Components
var tableView = UITableView()
var headerView = AccountSummaryHeaderView(frame: .zero)
let refreshControl = UIRefreshControl()

private func setup() {
    setupNavigationBar()
    setupTableView()
    setupTableHeaderView()
    setupRefreshControl() //
    fetchDataAndLoadViews()
}

private func setupRefreshControl() {
    refreshControl.tintColor = appColor
    refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
    tableView.refreshControl = refreshControl
}

DispatchQueue.main.async {
      self.myScrollingView.refreshControl?.endRefreshing()
}
```

## Skeleton loaders

Those nice shimmery boxes of grey that signal to the user things are loading.



### Links that help

- [UIRefeshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)

