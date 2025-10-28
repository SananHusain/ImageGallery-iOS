//
//  ImageServiceType.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation

protocol ImageServiceType {
    func fetchPage(page: Int, limit: Int) async throws -> [ImageItem]
}

final class ImageService: ImageServiceType {
    private let base = "https://picsum.photos/v2/list"
    private let client: APIClient

    init(client: APIClient = .shared) {
        self.client = client
    }

    func fetchPage(page: Int, limit: Int = 30) async throws -> [ImageItem] {
        guard var comps = URLComponents(string: base) else { return [] }
        comps.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        guard let url = comps.url else { return [] }
        return try await client.get(url: url)
    }
}