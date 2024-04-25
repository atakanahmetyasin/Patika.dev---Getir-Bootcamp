//
//  CartRouter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 18.04.2024.
//

import Foundation
import UIKit


enum CartRoutes {
    case listing
}

protocol CartRouterProtocol {
    func navigate(_ route: CartRoutes)
}

class CartRouter {
    weak var viewController: CartViewController?

    static func createModule() -> CartViewController {
       let view = CartViewController()
        let interactor = CartInteractor()
        let router = CartRouter()
        
        let presenter = CartPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter 
        router.viewController = view
        return view
    }
}

extension CartRouter: CartRouterProtocol {
    func navigate(_ route: CartRoutes) {
        switch route {
        case .listing:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
