//
//  ListingInteractor.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 8.04.2024.
//

import Foundation

protocol ListingInteractorProtocol {
    func fetchHorizontalData()
    func fetchVerticalData()
}

protocol ListingInteractorOutputProtocol: AnyObject {
    func interactorDidFetchHorizontalData(result: Result<[Product], Error>)
    func interactorDidFetchVerticalData(result: Result<[Product], Error>)
}

final class ListingInteractor: ListingInteractorProtocol {
    var presenter: ListingPresenterProtocol?
    weak var output: ListingInteractorOutputProtocol?
    var networkManager: NetworkManagerProtocol?
    
    init(networkManager: NetworkManagerProtocol? = NetworkManager()) {
        self.networkManager = networkManager
    }
 // ** constant.baseURL vs. şeklinde düzenle burayı
    func fetchHorizontalData() {
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/suggestedProducts") 
        else {
            print(NetworkError.urlError)
            return
        }
        networkManager?.fetchData(from: url) { [ weak self ]  (result: Result<[Product],NetworkError>) in
            switch result {
            case .success(let data):
                self?.output?.interactorDidFetchHorizontalData(result: .success(data))
            case .failure(let error):
                self?.output?.interactorDidFetchHorizontalData(result: .failure(NetworkError.parsingError))
                print(error, error.localizedDescription)
            }
        }
    }
    func fetchVerticalData() {
        guard let url = URL(string: "https://65c38b5339055e7482c12050.mockapi.io/api/products") else { 
            print(NetworkError.urlError)
            return
        }
    networkManager?.fetchData(from: url) { [ weak self ] (result: Result<[Product],NetworkError>) in
            switch result {
            case .success(let data):
                self?.output?.interactorDidFetchVerticalData(result: .success(data))
            case .failure(let error):
                self?.output?.interactorDidFetchVerticalData(result: .failure(NetworkError.parsingError))
                print(error, error.localizedDescription)
            }
        }
    }
}
