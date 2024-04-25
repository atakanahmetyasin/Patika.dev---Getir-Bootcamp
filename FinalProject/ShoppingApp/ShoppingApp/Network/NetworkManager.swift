//
//  NetworkManager.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 9.04.2024.
//

import UIKit

// Generic bir şekilde network katmanını oluşturdum.
class NetworkManager: NetworkManagerProtocol {
      func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                print(error, error.localizedDescription)
                completion(.failure(NetworkError.parsingError))
            }
        }
        dataTask.resume()
    }
    
    
}
