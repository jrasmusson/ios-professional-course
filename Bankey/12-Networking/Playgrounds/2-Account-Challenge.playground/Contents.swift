import UIKit

/*
   _                      _      ___ _         _ _
  /_\  __ __ ___ _  _ _ _| |_   / __| |_  __ _| | |___ _ _  __ _ ___
 / _ \/ _/ _/ _ \ || | ' \  _| | (__| ' \/ _` | | / -_) ' \/ _` / -_)
/_/ \_\__\__\___/\_,_|_||_\__|  \___|_||_\__,_|_|_\___|_||_\__, \___|
                                                         |___/
 
 See if you can fill in the blanks for the Account model below and parse
 the included JSON.
 
 - Use type `Decimal` for amount.
 - Use type `String` and `Date` for the others.
 
 But give it a go!
 
 */

let json = """
 [
   {
     "id": "1",
     "type": "Banking",
     "name": "Basic Savings",
     "amount": 929466.23,
     "createdDateTime" : "2010-06-21T15:29:32Z"
   },
   {
     "id": "2",
     "type": "Banking",
     "name": "No-Fee All-In Chequing",
     "amount": 17562.44,
     "createdDateTime" : "2011-06-21T15:29:32Z"
   },
  ]
"""

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

struct Account: Codable {
    // 🕹 Game on here
}

let jsonData = json.data(using: .utf8)!
let result = try! JSONDecoder().decode([Account].self, from: jsonData)

