# Networking

In this section we are going to add networking to our app.

## Codable

Let's quickly review how JSON and Codeable work.

## ResultType

Let's quickly review this dedicated enum called result type.

## Fetch Profile

- Explain plan of attach
  - Profile we are going to bring in directly as a ViewModel
  - Account we are going to translate translate so you can see both

Let's start by parsing profile.

This is the JSON we need to parse for a users profile.

[End point](https://fierce-retreat-36855.herokuapp.com/bankey/profile/1)

**Profile JSON**

```
{
"id": "1",
"first_name": "Kevin",
"last_name": "Flynn",
}
```

We are going to need a `Codeable` object to injest this in. Let's open a Swift playground and create it first there.

- Playgrounds are nice because...
- Note the use of `CodingKeys`.
- Names are tricky - could have called this:
 - `ProfileViewModel` because used in the view
 - `ProfileRequestModel` because it is also `Codeable`
 - We will go with `ProfileModel` and hope the `Codeable` protocol is enough to tell readers this struct is JSON parsable.

**Playground**

```swift
import UIKit

let json = """
{
"id": "1",
"first_name": "Kevin",
"last_name": "Flynn",
}
"""

struct ProfileModel: Codable {
    let id: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

let jsonData = json.data(using: .utf8)!
let result = try! JSONDecoder().decode(ProfileModel.self, from: jsonData)
```

OK - let's now repeat for `Accounts`.

## Fetch Accounts

[End point](https://fierce-retreat-36855.herokuapp.com/bankey/customer/1/accounts)

### Account Challenge

Open challenge playground.

### Account Solution

Open solution playground.

We can start like this:

```swift

struct AccountModel: Codable {
    // 🕹 Game on here
    let id: String
    let type: String
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}
```

But will run into trouble with the `Date`.

```
__lldb_expr_1/5-Account-Solution.playground:49: Fatal error: 'try!' expression unexpectedly raised an error: Swift.DecodingError.typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "Index 0", intValue: 0), CodingKeys(stringValue: "createdDateTime", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil))
```

This is an `iso8601` date and we need parse it in a special way.

```swift
// If iso8601 use dateEncodingStrategy.

let jsonIso = """
{
  "date" : "2017-06-21T15:29:32Z"
}
"""

let isoData = jsonIso.data(using: .utf8)!
let isoDecoder = JSONDecoder()
isoDecoder.dateDecodingStrategy = .iso8601
let isoResult = try! isoDecoder.decode(DateRecord.self, from: isoData)
isoResult.date
```

Fortunately it's not a lot of work. We just need to tell our decoder what `dateDecodingStrategy` to use.

```swift
let jsonData = json.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let result = try! decoder.decode([AccountModel].self, from: jsonData)
```

Voila. Accounts parsed.

### Add these models to our project

- Create a dir called `Models`.
- Add `AccountModel` and `ProfileModel` into there.

## Making the network calls

Now that we know we can parse the incoming JSON, we just need to do it for real by calling the end-point APIs.

Let's start with by creating a playground for `Profile` and see if we can test out our networking in there.




## Unit testing

Now as good as our playgrounds are, it would be really nice if we could capture this work in the form of an automated test.



### Links that help

