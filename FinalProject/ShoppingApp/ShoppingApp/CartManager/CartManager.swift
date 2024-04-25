//
//  CartProduct.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 22.04.2024.
//

import UIKit

// Global bir CartManager oluşturuyorum. Bu sayede sepet işlemlerini buradan yönetebilirim.
class CartManager {
    static let shared = CartManager()
    
    var cartItems: [CartStruct] = []
    
    func addItemToCart(imageURL: UIImage,price: Double, name: String, attribute: String, count: Int) {
        let newItem = CartStruct(imageURL: imageURL, price: price, name: name, attribute: attribute, count: count)
        cartItems.append(newItem)
        print("\(name) added to cart.")
    }
    
    func removeItemFromCart(at index: Int) {
        guard index >= 0, index < cartItems.count else {
            print("Invalid index.")
            return
        }
        let removedItem = cartItems.remove(at: index)
        print("\(removedItem.name) removed from cart.")
    }
    
    func removeAllItemsFromCart() {
        cartItems.removeAll()
        print("All items removed from cart.")
    }
    
    func getTotalCartPrice() -> Double {
        return cartItems.reduce(0.0) { $0 + $1.price }
    }
    
    func displayCartItems() {
        print("Cart Items:")
        for (index, item) in cartItems.enumerated() {
            print("\(index + 1). \(item.name) - \(item.price) TL")
        }
        print("Total Price: \(getTotalCartPrice()) TL")
    }
    //    func totalCount() -> Int {
    //           return cartItems.reduce(0) { $0 + $1.count }
    //       }
}
