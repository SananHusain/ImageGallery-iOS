//
//  DetailViewModel.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation
import UIKit

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var items: [ImageItem]
    @Published var selectedIndex: Int

    init(items: [ImageItem], selectedIndex: Int) {
        self.items = items
        self.selectedIndex = selectedIndex
        Task {
            await prefetchAround(index: selectedIndex)
        }
    }

    func prefetchAround(index: Int) async {
        let neighbors = [index - 1, index + 1].compactMap { i -> URL? in
            guard items.indices.contains(i), let url = URL(string: items[i].download_url) else { return nil }
            return url
        }
        await ImageCache.shared.prefetch(urls: neighbors)
    }

    func goTo(index: Int) {
        guard items.indices.contains(index) else { return }
        selectedIndex = index
        Task { await prefetchAround(index: index) }
    }
}