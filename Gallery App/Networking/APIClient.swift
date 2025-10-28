//
//  APIError.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation

enum APIError: Error {
    case network(Error)
    case invalidResponse
    case decoding(Error)
}

final class APIClient {
    static let shared = APIClient()
    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable>(url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                throw APIError.invalidResponse
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw APIError.decoding(error)
            }
        } catch {
            throw APIError.network(error)
        }
    }
}