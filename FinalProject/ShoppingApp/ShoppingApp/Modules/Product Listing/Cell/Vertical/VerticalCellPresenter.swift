//
//  VerticalCellPresenter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 17.04.2024.
//

import UIKit

protocol VerticalCellPresenterProtocol: AnyObject {
    func load()
    func setCount(_ count: Int)
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String)
    func removeBasketTapped(productName: String, productPrice: Double)
}

final class VerticalCellPresenter {
    
    
    weak var view: VerticalCellProtocol?
    private let productVertical: ProductElement
    private var count: Int = 0 {
        didSet {
            view?.setCount(count)
        }
    }
    //a
    let basketPresenter: BasketPresenterProtocol
    //b
    
    init(view: VerticalCellProtocol? = nil, productVertical: ProductElement,  basketPresenter: BasketPresenterProtocol) {
        self.view = view
        self.productVertical = productVertical
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

extension VerticalCellPresenter: VerticalCellPresenterProtocol {
    func setCount(_ count: Int) {
        self.count = count
    }
    
    // Burada UI işlemlerini yapıyorum.
    func load() {
        self.view?.setAttributeLabel(productVertical.shortDescription ?? productVertical.attribute ?? "")
        if let price = productVertical.price {
            self.view?.setPriceLabel(String(format: "₺%.2f", price ))
        }
        self.view?.setProductNameLabel(productVertical.name ?? "No Product")
        self.view?.setProductImageView(productVertical.imageURL ?? productVertical.squareThumbnailURL ?? "")
    }
}
