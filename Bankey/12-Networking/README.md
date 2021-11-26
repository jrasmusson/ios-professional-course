# Networking

In this section we are going to add networking to our app.

- Going to look at different ways of importing data in
- Different ways of utilizing tools like playgrounds
- And end looking at how we can unit test network code in our projects

## Profile

This is how we are going to do networking in our application.

Open playground. And go through.

1. Codeable
2. URLSession
3. Result


## Codable

- `Codeable` is actually a combination of x2 protocols
- Complying with this protocol, or alias, means your type can convert itself into and out of an external representation. In this case JSON.
- By using a `JSONDecoder` we can convert incoming messages into Swift objects, and if neccessary go in the other direction Swift > JSON.

[Examples](https://github.com/jrasmusson/level-up-swift/blob/master/11-JSON/1-json.md)


## URLSession

[Apple docs - Fetching website data into memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)

- Simple. Elegant. No need for third party libraries though many projects do.
- Main thing to note is when the completion block returns you may not necessarily be on the main thread.

But we can put ourselves there with code like this:

```swift
DispatchQueue.main.async {
   completion(.success(posts))
}
```

## ResultType

Let's quickly review this dedicated enum called result type.

## Fetch Accounts

Let's fetch account just like we did profile.

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

Note: This one is not a `ViewModel` we are going to do some translation. See how to do that in a moment.

## Bringing it into the app

Now when we do bring it into the project, we need to decide where to put it.

Discussion - how to add networking to view controller:

- func in ViewController (closest)
- create manager (if were going to reuse)
- extract into extension (if local to vc)
- point is to keep view controller as small and dumb as possible
- extract all other logic out

Current project I am working on goes the extension route - so let's put it there.

- Create a new class `AccountSummaryViewController+Networking`.
- Add the following network code into there

**AccountSummaryViewController+Networking**

```swift
import Foundation

enum NetworkError: Error {
    case domainError
    case decodingError
}

struct ProfileViewModel: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<ProfileModel,NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
                }
                return
            }
            
            do {
                let posts = try JSONDecoder().decode(ProfileViewModel.self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
```

Discussion:

- How are errors represented in Swift

Then to call it from our UI we need to update the vc as follows.

**AccountSummaryViewController**

```swift
class AccountSummaryViewController: UIViewController {
    
    var profile: ProfileViewModel?
```


There. We can now fetch and load profile data into our header.

Let's do the same for accounts. UR HERE

### Accounts

### Add to project

Discuss:


## Unit testing

Now as good as our playgrounds are, it would be really nice if we could capture this work in the form of an automated test.



### Links that help

- [Apple docs - Fetching website data into memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)