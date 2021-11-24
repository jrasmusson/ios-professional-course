// Swift Result Type

import Foundation

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case domainError
    case decodingError
}

func fetchPosts(url: URL, completion: @escaping (Result<[Post],NetworkError>) -> Void) {

    URLSession.shared.dataTask(with: url) { data, response, error in

        guard let data = data, error == nil else {
            if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    completion(.failure(.domainError))
            }
            return
        }

        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            completion(.success(posts))
        } catch {
            completion(.failure(.decodingError))
        }

    }.resume()

}

fetchPosts(url: url) { result in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error.localizedDescription)
    }
}

// Returning success/failure

// completion(.success(posts))
// completion(.success(())) if no result
// completion(.failure(.domainError))
//completion(.failure(.decodingError))



























// Example of divide by zero
// https://theswiftdev.com/2019/01/28/how-to-use-the-result-type-to-handle-errors-in-swift/

// https://medium.com/@azamsharp/understanding-result-type-in-swift-5-387d5ef9f45e



