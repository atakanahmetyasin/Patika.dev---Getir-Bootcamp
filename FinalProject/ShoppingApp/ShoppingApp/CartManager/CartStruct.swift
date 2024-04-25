//
//  CartItem.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 22.04.2024.
//

import UIKit

struct CartStruct {
    var imageURL: UIImage
    var price: Double
    var name: String
    var attribute: String
    var count: Int
    
    init(imageURL: UIImage, price: Double, name: String, attribute: String, count: Int) {
        self.imageURL = imageURL
        self.price = price
        self.name = name
        self.attribute = attribute
        self.count = count
    }
}



