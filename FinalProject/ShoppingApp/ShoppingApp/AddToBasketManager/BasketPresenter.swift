//
//  BasketPresenter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 24.04.2024.
//


// TODO: BURAYI HALLET, GLOBAL EKRANDAN İŞLEMLERİ YAP

import UIKit
protocol BasketView: AnyObject {
    func setIsAddToBasketDidTap(_ isAddToBasketDidTap: Bool)
}

protocol BasketPresenterProtocol {
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String, count: Int)
    func removeBasketTapped(productName: String, productPrice: Double)
}

class BasketPresenter: BasketPresenterProtocol {
    static let shared = BasketPresenter(cartManager: CartManager())
    private let cartManager: CartManager
     var count: Int = 0
    var totalPrice = 0.0
    weak var view: BasketView?
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
    
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String, count: Int) {
        if let existingItemIndex = CartManager.shared.cartItems.firstIndex(where: { $0.name == productName }) {
            CartManager.shared.cartItems[existingItemIndex].count += 1
            CartManager.shared.cartItems[existingItemIndex].price += productPrice
        } else {
            // Ürünü sepete ekliyorum.
            CartManager.shared.addItemToCart(imageURL: image ,
                                             price: productPrice,
                                             name: productName,
                                             attribute: attribute,
                                             count: 1)
        }
//        self.count += 1
        NotificationCenter.default.post(name: NSNotification.Name("updateTotalPrice"), object: nil)
    }
    
    func removeBasketTapped(productName: String, productPrice: Double) {
        if let existingItemIndex = CartManager.shared.cartItems.firstIndex(where: { $0.name == productName }) {
            if CartManager.shared.cartItems[existingItemIndex].count > 1 {
                CartManager.shared.cartItems[existingItemIndex].count -= 1
                CartManager.shared.cartItems[existingItemIndex].price -= productPrice
            } else {
                CartManager.shared.removeItemFromCart(at: existingItemIndex)
            }
        }
        
        count -= 1
        if count < 1 {
//            view?.setIsAddToBasketDidTap(false)
        }
        NotificationCenter.default.post(name: NSNotification.Name("updateTotalPrice"), object: nil)
    }

}
