//
//  ListingRouter.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//
import UIKit

//
enum ListingRoutes {
    //a
//    case detail
    //b
    case cart
   
}


protocol ListingRouterProtocol {
//a
    func routeToDetail(with id: String?, productElement: ProductElement, totalPrice: String)
    //b
    func navigate(_ route: ListingRoutes)

}

final class ListingRouter {
    weak var viewController: ListingViewController?
    
    static func createModule() -> ListingViewController {
        let view = ListingViewController()
        let interactor = ListingInteractor()
        let router = ListingRouter()
        
        let presenter = ListingPresenter(view: view, router: router, interactor: interactor)
        

        
        view.presenter = presenter
        
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension ListingRouter: ListingRouterProtocol {

    
    //a
    func routeToDetail(with id: String?, productElement: ProductElement, totalPrice: String) {
            let detailVC = ProductDetailRouter.createModule()
        detailVC.presenter?.productId = id
        detailVC.presenter?.productDetail = productElement
        detailVC.presenter?.totalPrice = totalPrice
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    //b
    
    func navigate(_ route: ListingRoutes) {
        switch route {
        case .cart:
            let cartVC = CartRouter.createModule()
            viewController?.navigationController?.pushViewController(cartVC, animated: true)
//        case .detail:
//            let detailsVC = ProductDetailRouter.createModule()
//            viewController?.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}
