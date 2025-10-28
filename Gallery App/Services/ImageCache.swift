//
//  ImageCache.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let memCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDir: URL

    private init() {
        cacheDir = try! fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("ImageGalleryCache")
        if !fileManager.fileExists(atPath: cacheDir.path) {
            try? fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true)
        }
    }

    func image(forKey key: String) -> UIImage? {
        if let img = memCache.object(forKey: key as NSString) { return img }
        let diskURL = cacheDir.appendingPathComponent(keyToFileName(key))
        if let data = try? Data(contentsOf: diskURL), let img = UIImage(data: data) {
            memCache.setObject(img, forKey: key as NSString)
            return img
        }
        return nil
    }

    func store(_ image: UIImage, forKey key: String) {
        memCache.setObject(image, forKey: key as NSString)
        let diskURL = cacheDir.appendingPathComponent(keyToFileName(key))
        guard let data = image.jpegData(compressionQuality: 0.9) else { return }
        try? data.write(to: diskURL)
    }

    private func keyToFileName(_ key: String) -> String {
        return key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }

    // Prefetch helper
    func prefetch(urls: [URL]) async {
        for url in urls {
            let key = url.absoluteString
            if image(forKey: key) != nil { continue }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let img = UIImage(data: data) {
                    store(img, forKey: key)
                }
            } catch {
                // ignore
            }
        }
    }
}