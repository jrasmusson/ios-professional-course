# Networking

## Codable

Let's quickly review how JSON and Codeable work.

## ResultType

Let's quickly review this dedicated enum called result type.

## Fetching Accounts

To fetch accounts for our `AccountSummaryViewController` we are going to need a `Codeable` struct capable of parsing this.

[End point](https://fierce-retreat-36855.herokuapp.com/bankey/customer/1/accounts)

It returns JSON that looks like this:

```
[
  {
    "id": "1",
    "type": "Banking",
    "name": "Basic Savings",
    "amount": 929466.23,
  },
  {
    "id": "2",
    "type": "Banking",
    "name": "No-Fee All-In Chequing",
    "amount": 17562.44,
  }
 ]
```

Let's create a Swift Playground and do some parsing in there.

```swift
import Foundation

let json = """
 [
   {
     "id": "1",
     "type": "Banking",
     "name": "Basic Savings",
     "amount": 929466.23,
   },
   {
     "id": "2",
     "type": "Banking",
     "name": "No-Fee All-In Chequing",
     "amount": 17562.44,
   }
  ]
"""

struct AccountModel: Codable {
    let id: String
    let type: String
    let name: String
    let amount: Decimal
}

let jsonData = json.data(using: .utf8)!
let result = try! JSONDecoder().decode([AccountModel].self, from: jsonData)
```

### Challenge

Open up this other playground. And see if you can create the `Codeable` model for `Profile`.

End point.

```swift

```

### Solution


### Unit test

Now this is good. We just need to copy our playground code over to our project and we'd be good to go. But you know what would be even better? If we could take our playground with us.

Let's write a unit test capable of testing our JSON parsons, and bring `Account` into our project.








## Fetching Profiles

Let's also fetch profiles.

## Unit testing


### Links that help

