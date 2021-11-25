import UIKit

/*
 ___          __ _ _        ___ _         _ _
| _ \_ _ ___ / _(_) |___   / __| |_  __ _| | |___ _ _  __ _ ___
|  _/ '_/ _ \  _| | / -_) | (__| ' \/ _` | | / -_) ' \/ _` / -_)
|_| |_| \___/_| |_|_\___|  \___|_||_\__,_|_|_\___|_||_\__, \___|
                                                      |___/

 See if you can fill out the details to parse the following JSON
 into the `ProfileModel`.

 Bonus: Try doing this two ways. One as is. The other mapping the keys to
 more Swift like variable names.
 */


import Foundation

let json = """
{
"id": "1",
"first_name": "Kevin",
"last_name": "Flynn",
}
"""

// Option 1: Match names
//struct ProfileModel: Codable {
//    // 🕹 Game on here
//    let id: String
//    let first_name: String
//    let last_name: String
//}

// Option 2: Map names with keys
struct ProfileModel: Codable {
    // 🕹 Game on here
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
