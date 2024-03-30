//
//  APIManager.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import Foundation

class APIManager: ServiceProtocol {
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T,NetworkError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.urlError))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.responseError))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.responseError))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print(error)
                completion(.failure(NetworkError.parsingError))
            }
        }
            dataTask.resume()
    }
}
