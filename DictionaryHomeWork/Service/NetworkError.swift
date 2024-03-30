//
//  Error.swift
//  DictionaryHomeWork
//
//  Created by Ahmet Yasin Atakan on 21.03.2024.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case responseError
    case dataError
    case parsingError
}
