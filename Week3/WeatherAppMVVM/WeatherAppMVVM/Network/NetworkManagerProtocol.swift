//
//  NetworkManagerProtocol.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void)
}
