//
//  NetworkManager.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import UIKit

class NetworkManager: UIViewController, NetworkManagerProtocol {
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print(NetworkError.errorParsing)
            }
            guard let data else {
                print(NetworkError.noData)
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                print("Error Parsing Data \(error)")
                completion(.failure(NetworkError.errorParsing))
            }
        }
        dataTask.resume()
    }
}
