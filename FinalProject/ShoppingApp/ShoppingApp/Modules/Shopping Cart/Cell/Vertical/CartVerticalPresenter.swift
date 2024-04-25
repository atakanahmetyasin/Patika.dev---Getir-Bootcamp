
import UIKit

protocol CartVerticalCellPresenterProtocol: AnyObject {
    func setCount(_ count: Int)
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String)
    func removeBasketTapped(productName: String, productPrice: Double)
}

final class CartVerticalCellPresenter {
    
    weak var view: CartVerticalCellProtocol?
    private let productVertical: ProductElement
    private var count: Int = 0 {
        didSet {
            view?.setCount(count)
        }
    }
    //a
    let basketPresenter: BasketPresenterProtocol
    //b
    
    init(view: CartVerticalCellProtocol? = nil, productVertical: ProductElement,  basketPresenter: BasketPresenterProtocol = BasketPresenter(cartManager: CartManager())) {
        self.view = view
        self.productVertical = productVertical
        self.basketPresenter = basketPresenter
    }
   // basketPresenter: BasketPresenter(cartManager: CartManager())
}

extension CartVerticalCellPresenter: CartVerticalCellPresenterProtocol {
    // CartItems arrayini geziyorum. Eğer bir ürün birden fazlaysa(isminin aynı olup olmamasına bakıyorum) "count" değerini 1 arttırıyorum ve "price" değerini güncelliyorum.
    // Else durumunda ise ürünü sepete ekliyorum.
    func addBasketTapped(image: UIImage, productPrice: Double, productName: String, attribute: String) {
//        basketPresenter.addBasketTapped(image: image, productPrice: productPrice, productName: productName, attribute: attribute, count: self.count)
        count += 1
//        view?.setIsAddToBasketDidTap(true)
    }
    
    func removeBasketTapped(productName: String, productPrice: Double) {
        basketPresenter.removeBasketTapped(productName: productName, productPrice: productPrice)
        count -= 1
        if count < 1 {
            view?.setIsAddToBasketDidTap(false)
        }
    }
    
    func setCount(_ count: Int) {
        self.count = count
    }
}
