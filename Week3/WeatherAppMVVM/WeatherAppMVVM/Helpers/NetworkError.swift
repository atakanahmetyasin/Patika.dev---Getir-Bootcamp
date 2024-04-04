//
//  Error.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import Foundation


enum NetworkError: Error {
    case InvalidURL
    case noData
    case errorParsing
}
