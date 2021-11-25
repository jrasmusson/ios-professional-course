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
