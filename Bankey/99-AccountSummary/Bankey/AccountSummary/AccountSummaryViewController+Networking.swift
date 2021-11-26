//
//  AccountSummaryViewController+Networking.swift
//  Bankey
//
//  Created by jrasmusson on 2021-11-26.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case serverError
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
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<ProfileViewModel,NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
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
