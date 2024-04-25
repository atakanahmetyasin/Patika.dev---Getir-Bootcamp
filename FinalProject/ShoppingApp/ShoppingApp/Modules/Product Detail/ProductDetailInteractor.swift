//
//  ProductDetailInteractor.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 10.04.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol: AnyObject {
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutputProtocol?
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {

}

