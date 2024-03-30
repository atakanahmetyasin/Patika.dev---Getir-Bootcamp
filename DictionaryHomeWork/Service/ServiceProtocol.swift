//
//  ServiceProtocol.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import Foundation

protocol ServiceProtocol {
    func fetchData<T: Codable>(from url: URL, completion: @escaping (Result<T,NetworkError>) -> Void)
}
