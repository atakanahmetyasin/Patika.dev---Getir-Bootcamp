//
//  CartPresenter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 18.04.2024.
//

import UIKit

protocol CartPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    var cartSuggested: [Product] { get set }
    var productElementSuggested: [ProductElement] { get set }
    
    var productElementVertical: [ProductElement] {get set}
    
    func numberOfVerticalItems() -> Int
    func numberOfSuggestedItems() -> Int
    
    func productElementSuggested(_ index: Int) -> ProductElement?
    func didSelectRowAt(index: Int)
    
    func showListing()
    //a
 
    //b
}

final class CartPresenter {
    unowned var view: CartViewControllerProtocol!
    var interactor: CartInteractorProtocol!
    var router: CartRouterProtocol!
    var cartSuggested: [Product] = []
    var productElementSuggested: [ProductElement] = []
    var productElementVertical: [ProductElement] = []
    
    init(view: CartViewControllerProtocol?, interactor: CartInteractorProtocol?, router: CartRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CartPresenter: CartInteractorOutputProtocol {
    func fetchSuggestedData(result: Result<[Product], NetworkError>) {
        switch result {
        case  .success(let data):
            DispatchQueue.main.async {
                self.cartSuggested = data
                self.productElementSuggested = (data.first?.products)!
                self.view?.reloadData()
            }
        case .failure(let error):
            DispatchQueue.main.async {
                print(error, error.localizedDescription)
            }
        }
    }
}

extension CartPresenter: CartPresenterProtocol {
    func viewDidLoad() {
        interactor?.fetchSuggestedData()
    }
    
    func numberOfVerticalItems() -> Int {
        return CartManager.shared.cartItems.count
    }
    
    func numberOfSuggestedItems() -> Int {
        return productElementSuggested.count
    }
    
    func productElementSuggested(_ index: Int) -> ProductElement? {
        return productElementSuggested[index]
    }
    
    func didSelectRowAt(index: Int) {
        
    }
    func showListing() {
        router.navigate(.listing)
    }
}
