//
//  ProductDetailRouter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 10.04.2024.
//

import UIKit

enum DetailRoutes {
    case cart
}

protocol ProductDetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

final class ProductDetailRouter {
    weak var viewController: ProductDetailViewController?
    
    static func createModule() -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let router = ProductDetailRouter()
        let interactor = ProductDetailInteractor()
        
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor, basketPresenter: BasketPresenter(cartManager: CartManager()))
        
        view.presenter = presenter
        router.viewController = view
        interactor.output = presenter
        
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterProtocol {
    
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .cart:
            let cartVC = CartRouter.createModule()
            viewController?.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
}
