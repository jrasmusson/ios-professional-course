//
//  AccountModel.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-25.
//

import Foundation

struct AccountModel: Codable {
    let id: String
    let type: String
    let name: String
    let amount: Decimal
    let createdDateTime: Date
}
