//
//  ImageItem.swift
//  Gallery App
//
//  Created by Sanan Husain on 27/10/25.
//


import Foundation

struct ImageItem: Codable, Identifiable, Equatable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String

    var aspectRatio: Double { Double(width) / Double(height) }
}