//
//  CartInteractor.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 18.04.2024.
//

import Foundation

protocol CartInteractorProtocol {
    func fetchSuggestedData()
}

protocol CartInteractorOutputProtocol: AnyObject {
    func fetchSuggestedData(result: Result<[Product], NetworkError>)
}

final class CartInteractor: CartInteractorProtocol {
    weak var presenter: CartPresenterProtocol?
    weak var output: CartInteractorOutputProtocol?
    var networkManager: NetworkManagerProtocol?
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchSuggestedData() {
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts") else {
            print("Wrong URL")
            return
        }
        networkManager?.fetchData(from: url) { (result: Result<[Product],NetworkError>) in
            switch result {
            case .success(let data):
                self.output?.fetchSuggestedData(result: .success(data))
            case .failure(let error):
                self.output?.fetchSuggestedData(result: .failure(NetworkError.parsingError))
                print(error, error.localizedDescription)
            }
        }   
    }

}

