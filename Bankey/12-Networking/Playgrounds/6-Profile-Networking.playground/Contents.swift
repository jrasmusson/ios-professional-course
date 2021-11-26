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

enum NetworkError: Error {
    case serverError
    case decodingError
}

func fetchProfile(forUserId userId: String, completion: @escaping (Result<ProfileModel,NetworkError>) -> Void) {
    let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

    URLSession.shared.dataTask(with: url) { data, response, error in

        guard let data = data, error == nil else {
            completion(.failure(.serverError))
            return
        }
        
        do {
            let posts = try JSONDecoder().decode(ProfileModel.self, from: data)
            completion(.success(posts))
        } catch {
            completion(.failure(.decodingError))
        }
    }.resume()

}

fetchProfile(forUserId: "1") { result in
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
