//
//  SuggestedCellPresenter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 25.04.2024.
//

import UIKit

protocol SuggestedCellPresenterProtocol {
    func setCount(_ count: Int)
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String)
    func removeBasketTapped(productName: String, productPrice: Double)
}

final class SuggestedCellPresenter {
    
    let basketPresenter: BasketPresenterProtocol

    weak var view: SuggestedCellProtocol?
    private let productHorizontal: ProductElement
     var count: Int = 0 {
        didSet {
            view?.setCount(count)
        }
    }
    init(view: SuggestedCellProtocol,
         productHorizontal: ProductElement,
         basketPresenter: BasketPresenterProtocol) {
        self.view = view
        self.productHorizontal = productHorizontal
        self.basketPresenter = basketPresenter
    }
    
    // CartItems arrayini geziyorum. Eğer bir ürün birden fazlaysa(isminin aynı olup olmamasına bakıyorum) "count" değerini 1 arttırıyorum ve "price" değerini güncelliyorum.
    // Else durumunda ise ürünü sepete ekliyorum.
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String) {
        basketPresenter.addBasketTapped(image: image, productPrice: productPrice, productName: productName, attribute: attribute, count: self.count)
        count += 1
        view?.setIsAddToBasketDidTap(true)
    }
    
    func removeBasketTapped(productName: String, productPrice: Double) {
        basketPresenter.removeBasketTapped(productName: productName, productPrice: productPrice)
        count -= 1
        if count < 1 {
            view?.setIsAddToBasketDidTap(false)
        }
    }

}

extension SuggestedCellPresenter: SuggestedCellPresenterProtocol {
    func setCount(_ count: Int) {
    }
}
