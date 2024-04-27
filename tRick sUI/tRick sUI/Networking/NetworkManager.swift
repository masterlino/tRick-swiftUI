//
//  NetworkManager.swift
//  tRick sUI
//
//  Created by Lino Bustamante on 27/4/24.
//

import Foundation
import SystemConfiguration

class NetworkManager {
//    static let shared = NetworkManager()
//
//    private init() {}
//
//    var isConnected: Bool {
//        let reachability = NetworkReachabilityManager()
//        return reachability.startMonitoringForInternetConnection() && reachability.isReachable
//    }
//
//    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
//        guard isConnected else {
//            completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: ["message": "No internet connection"])))
//            return
//        }
//
//        let url = URL(string: "https://rickandmortyapi.com/api/character")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data, let response = response as? HTTPURLResponse else {
//                completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: nil)))
//                return
//            }
//
//            if response.statusCode != 200 {
//                completion(.failure(NSError(domain: "APIError", code: response.statusCode, userInfo: nil)))
//                return
//            }
//
//            do {
//                let characters = try JSONDecoder().decode([Character].self, from: data)
//                completion(.success(characters))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
}
