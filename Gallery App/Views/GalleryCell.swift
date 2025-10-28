//
//  GalleryCell.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//

import SwiftUI

struct GalleryCell: View {
    let item: ImageItem

    var body: some View {
        VStack(spacing: 4) {
            AsyncCachedImage(
                url: URL(string: item.download_url + "?w=200&h=200"),
                placeholder: Color.gray.opacity(0.2)
            )
            .frame(width: 70, height: 70) // fixed cell size
            .cornerRadius(6)
            .clipped()

            Text(item.author)
                .font(.caption2)
                .lineLimit(1)
                .frame(width: 70)
        }
    }
}

