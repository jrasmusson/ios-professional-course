//
//  ProfileModel.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-25.
//

import Foundation

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
