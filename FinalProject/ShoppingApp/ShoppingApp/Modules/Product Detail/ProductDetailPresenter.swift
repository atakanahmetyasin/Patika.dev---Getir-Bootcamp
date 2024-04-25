//
//  CreatePresenter.swift
//  Week-4-VIPER
//
//  Created by Kerim Çağlar on 6.04.2024.
//

import UIKit

protocol ProductDetailPresenterProtocol: AnyObject {
    //a
    var productId: String? { get set }
    var productDetail: ProductDetailItems? { get set }
    func productDetails(_ detail: ProductElement)
    func showCart()
    
    func setCount(_ count: Int)
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String)
    func removeBasketTapped(productName: String, productPrice: Double)
    
    var count: Int { get set }
    
    //a
    var totalPrice: String? { get set }
    //b
}

final class ProductDetailPresenter {
    unowned var view: ProductDetailViewControllerProtocol!
    let router: ProductDetailRouterProtocol!
    let interactor: ProductDetailInteractorProtocol!
    //a
    var totalPrice: String?
    //b
    var productId: String?
    var productDetail: ProductDetailItems?
     var count: Int = 0 {
        didSet {
            view?.setCount(count)
        }
    }
    var basketPresenter: BasketPresenterProtocol
    
    init(view: ProductDetailViewControllerProtocol,
         router: ProductDetailRouterProtocol,
         interactor: ProductDetailInteractorProtocol,
         basketPresenter: BasketPresenterProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.basketPresenter = basketPresenter
    }
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    //a
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String) {
        basketPresenter.addBasketTapped(image: image, productPrice: productPrice, productName: productName, attribute: attribute, count: self.count)
        count += 1
        view?.setIsAddToBasketDidTap(true)
    }
    
    func setCount(_ count: Int) {
        self.count = count
    }
    
    func removeBasketTapped(productName: String, productPrice: Double) {
        basketPresenter.removeBasketTapped(productName: productName, productPrice: productPrice)
        count -= 1
        if count < 1 {
            view?.setIsAddToBasketDidTap(false)
        }
    }

    //b
    func showCart() {
        router.navigate(.cart)
    }
    
    func productDetails(_ detail: ProductElement) {
        self.productDetail = detail
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.view?.setupViews()
        }
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    
}





