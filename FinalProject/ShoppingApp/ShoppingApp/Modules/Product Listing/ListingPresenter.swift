//
//  ListingPresenter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import Foundation

protocol ListingPresenterProtocol {
    var productElement: [ProductElement] { get set }
    var productElementVertical: [ProductElement] { get set }
    func viewDidLoad()
    func numberOfVerticalItems() -> Int
    func numberOfHorizontalItems() -> Int
    func productElementVertical(_ index: Int) -> ProductElement?
    func productElementHorizontal(_ index: Int) -> ProductElement?
    //    func createCompositionalLayout() -> UICollectionViewLayout
    func showCart()
    func productDetailVertical(_ index: Int)
    func productDetailHorizontal(_ index: Int)
}

typealias ViewProtocol = ListingViewControllerProtocol

final class ListingPresenter {
    unowned var view: ViewProtocol!
    var router: ListingRouterProtocol!
    var interactor: ListingInteractorProtocol!
    
    var productElement: [ProductElement] = []
    var productElementVertical: [ProductElement] = []
    
    init(view: ViewProtocol!, router: ListingRouterProtocol!, interactor: ListingInteractorProtocol!) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ListingPresenter: ListingPresenterProtocol {
    // Dikey Görünümdeki Veri geçişini sağlamak için gerekli düzenlemeleri yapıyorum.
    func productDetailVertical(_ index: Int) {
        if let totalPrice = view.totalPriceLabel.text {
            router.routeToDetail(with: productElementVertical[index].id, productElement: productElementVertical[index], totalPrice: totalPrice)
        }
    }
    // Yatay görünümdeki veri geçişi işlemlerini yapıyorum.
    func productDetailHorizontal(_ index: Int) {
        if let totalPrice = view.totalPriceLabel.text {
            router.routeToDetail(with: productElement[index].id, productElement: productElement[index], totalPrice: totalPrice)
        }
    }
    
    func viewDidLoad() {
        interactor?.fetchHorizontalData()
        interactor?.fetchVerticalData()
    }
    
    func numberOfVerticalItems() -> Int {
        return productElementVertical.count
    }
    
    func numberOfHorizontalItems() -> Int {
        return productElement.count
    }
    
    func productElementVertical(_ index: Int) -> ProductElement? {
        productElementVertical[index]
    }
    func productElementHorizontal(_ index: Int) -> ProductElement? {
        productElement[index]
    }
    
    func showCart() {
        router.navigate(.cart)
    }
    
}

extension ListingPresenter: ListingInteractorOutputProtocol {
    func interactorDidFetchHorizontalData(result: Result<[Product], Error>) {
        switch result {
        case .success(let data):
            DispatchQueue.main.async { [ weak self] in
                self?.productElement = (data.first?.products)!
                self?.view.reloadData()
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                print(error, error.localizedDescription)
            }
        }
    }
    
    func interactorDidFetchVerticalData(result: Result<[Product], Error>) {
        switch result {
        case .success(let data):
            DispatchQueue.main.async { [ weak self ] in
                self?.productElementVertical = (data.first?.products)!
                self?.view.reloadData()
            }
            
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                print(error, error.localizedDescription)
            }
        }
    }
    
}
