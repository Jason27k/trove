//
//  API.swift
//  anime-v2
//
//  Created by Jason Morales on 8/5/24.
//

import Foundation

enum APIErrors: Error {
    case invalidURL
    case invalidResponse
}

class AnimeAPI {
    func fetch<T: Decodable>(urlString: String) async throws -> T {
        print("Called")
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw APIErrors.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                print("Invalid response")
                throw APIErrors.invalidResponse
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Invalid Data")
            print(error)
            throw error
        }
    }
}
