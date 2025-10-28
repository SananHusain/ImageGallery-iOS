//
//  GalleryViewModel.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation
import UIKit

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published private(set) var items: [ImageItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var page = 1
    private let limit = 30
    private let service: ImageServiceType

    init(service: ImageServiceType = ImageService()) {
        self.service = service
    }

    func loadNextIfNeeded(currentItem: ImageItem?) async {
        guard !isLoading else { return }
        // if nil -> initial load; if approaching bottom -> load next
        if currentItem == nil || shouldLoadNext(currentItem: currentItem!) {
            await loadNextPage()
        }
    }

    private func shouldLoadNext(currentItem: ImageItem) -> Bool {
        guard let last = items.last else { return true }
        // when the current item is within last 6 items, page more
        if currentItem.id == last.id { return true }
        if let index = items.firstIndex(of: currentItem) {
            return (items.count - index) < 6
        }
        return false
    }

    private func loadNextPage() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let new = try await service.fetchPage(page: page, limit: limit)
            if new.isEmpty {
                // no more
            } else {
                items.append(contentsOf: new)
                page += 1
            }
        } catch {
            errorMessage = String(describing: error)
        }
    }

    func refresh() async {
        page = 1
        items = []
        await loadNextPage()
    }
}