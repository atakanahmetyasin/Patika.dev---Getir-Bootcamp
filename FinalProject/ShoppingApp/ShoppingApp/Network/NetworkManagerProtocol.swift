//
//  NetworkManagerProtocol.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 9.04.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T,NetworkError>) -> Void)
}
