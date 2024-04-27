//
//  APIClient.swift
//  tRick sUI
//
//  Created by Lino Bustamante on 27/4/24.
//

import Foundation

import Foundation

class APIClient {
    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func fetchCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/character")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: nil)))
                return
            }

            if response.statusCode != 200 {
                completion(.failure(NSError(domain: "APIError", code: response.statusCode, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(CharacterResponse.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
