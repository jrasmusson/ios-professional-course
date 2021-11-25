# Networking

In this section we are going to add networking to our app.

- Going to look at different ways of importing data in
- Different ways of utilizing tools like playgrounds
- And end looking at how we can unit test network code in our projects

## Let's head to the playground

- Create a new playground.
- Copy the following code into it.

```swift
import Foundation

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case domainError
    case decodingError
}

func fetchPosts(url: URL, completion: @escaping (Result<[Post],NetworkError>) -> Void) {

    URLSession.shared.dataTask(with: url) { data, response, error in

        guard let data = data, error == nil else {
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
            }
            return
        }

        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            completion(.success(posts))
        } catch {
            completion(.failure(.decodingError))
        }

    }.resume()

}

fetchPosts(url: url) { result in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Returning success/failure
// completion(.success(posts))
// completion(.failure(.domainError))
// completion(.success(())) if no result
```

This is how we are going to do networking in our application.

- `URLSession.shared.dataTask` is how we are going to make network calls
- `Codeable` is the protocol we are going to adhere to to parse JSON returned from our requests
- `Result` is the return type we are going to use in our completion block to indicate success for failure.

Let's review each of these quickly.

## URLSession

- Simple. Elegant. No need for third party libraries though many projects do.
- Main thing to note is when the completion block returns you may not necessarily be on the main thread.

But we can put ourselves there with code like this:

```swift
DispatchQueue.main.async {
   completion(.success(posts))
}
```

We will look at an example of where/how to do that later.


## Codable

- `Codeable` is actually a combination of x2 protocols
- Complying with this protocol, or alias, means your type can convert itself into and out of an external representation. In this case json.
- By using a `JSONDecoder` we can convert incoming messages into Swift objects, and if neccessary go in the other direction Swift > JSON.

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

### Profile

- Create a new class `AccountSummaryViewController+Networking`.
- Add the following network code into there
- Update our UI to get the results as follows.

There. We can now fetch and load profile data into our header.

Let's do the same for accounts. UR HERE

### Accounts

### Add to project

Discuss:

- different ways we could add
- func in ViewController
- create manager and inject in as a variable
- extract into extension
- point is to keep view controller as small and dumb as possible
- extract all other logic out

## Unit testing

Now as good as our playgrounds are, it would be really nice if we could capture this work in the form of an automated test.



### Links that help

