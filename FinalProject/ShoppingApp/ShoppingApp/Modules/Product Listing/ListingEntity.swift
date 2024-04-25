//
//  ListingEntity.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import Foundation

struct Product: Codable {
    let products: [ProductElement]?
    let id, name: String?
    let productCount: Int?
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: String
    let imageURL: String?
    let price: Double?
    let name, priceText: String?
    let shortDescription, category, attribute: String?
    let unitPrice: Double?
    let squareThumbnailURL, thumbnailURL: String?
    let status: Int?
}
