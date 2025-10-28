//
//  AsyncCachedImage.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import SwiftUI

struct AsyncCachedImage<Placeholder: View>: View {
    let url: URL?
    let placeholder: Placeholder

    @State private var uiImage: UIImage? = nil

    var body: some View {
        ZStack {
            if let img = uiImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
                    .onAppear { Task { await load() } }
            }
        }
        .clipped()
    }

    private func load() async {
        guard let url = url else { return }
        let key = url.absoluteString
        if let cached = ImageCache.shared.image(forKey: key) {
            uiImage = cached
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let img = UIImage(data: data) {
                ImageCache.shared.store(img, forKey: key)
                await MainActor.run { uiImage = img }
            }
        } catch {
            // ignore for now; you can expose errors via callback
        }
    }
}