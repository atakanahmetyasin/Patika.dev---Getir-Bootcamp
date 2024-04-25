//
//  ProductDetailEntity.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 24.04.2024.
//

import Foundation

protocol ProductDetailItems {
    var productId: String? { get }
    var productName: String? { get }
    var productImage: String? { get }
    var productAttribute: String? { get }
    var productPrice: String? { get }
}

extension ProductElement: ProductDetailItems {
    var productId: String? {
        id
    }
    
    var productName: String? {
        name
    }
    
    var productImage: String? {
        imageURL ?? thumbnailURL ?? squareThumbnailURL
    }
    
    var productAttribute: String? {
        shortDescription ?? attribute
    }
    
    var productPrice: String? {
        priceText
    }
}
