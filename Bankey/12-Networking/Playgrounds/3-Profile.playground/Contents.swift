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
