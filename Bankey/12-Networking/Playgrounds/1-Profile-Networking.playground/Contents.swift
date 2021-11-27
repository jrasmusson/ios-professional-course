import Foundation

/*
 1. Codeable
 2. URLSession
 3. Result
 */

let json = """
        {
        "id": "1",
        "first_name": "Jonathan",
        "last_name": "Smith",
        }
        """

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
    let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            completion(.failure(.serverError))
            return
        }
        
        do {
            let profile = try JSONDecoder().decode(Profile.self, from: data)
            completion(.success(profile))
        } catch {
            completion(.failure(.decodingError))
        }
    }.resume()

}

fetchProfile(forUserId: "1") { result in
    switch result {
    case .success(let profile):
        print(profile)
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Returning success/failure
// completion(.success(posts))
// completion(.failure(.domainError))
