

import UIKit

protocol HorizontalCellPresenterProtocol: AnyObject {
    func load()
    func setCount(_ count: Int)
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String)
    func removeBasketTapped(productName: String, productPrice: Double)
}

final class HorizontalCellPresenter {
    
    let basketPresenter: BasketPresenterProtocol

    weak var view: HorizontalCellProtocol?
    private let productHorizontal: ProductElement
     var count: Int = 0 {
        didSet {
            view?.setCount(count)
        }
    }
    init(view: HorizontalCellProtocol,
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

extension HorizontalCellPresenter: HorizontalCellPresenterProtocol {
    func setCount(_ count: Int) {
    }
    
    // Burada UI işlemlerini yapıyorum.
    func load() {
        self.view?.setAttributeLabel(productHorizontal.shortDescription ?? productHorizontal.attribute ?? "")
        if let price = productHorizontal.price {
            self.view?.setPriceLabel(String(format: "₺%.2f", price ))
        }
        self.view?.setProductNameLabel(productHorizontal.name ?? "No Product")
        self.view?.setProductImageView(productHorizontal.imageURL ?? productHorizontal.squareThumbnailURL ?? "")
    }
}
