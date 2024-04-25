//
//  NetworkError.swift
//  ShoppingApp
//
//  Created by Ahmet Yasin Atakan on 18.04.2024.
//

import Foundation

enum NetworkError: Error {
    case networkFailed
    case urlError
    case dataError
    case parsingError
}
