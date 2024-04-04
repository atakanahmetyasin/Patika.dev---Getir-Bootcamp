//
//  NetworkManagerOutputProtocol.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 3.04.2024.
//

import Foundation

protocol NetworkManagerOutputProtocol: AnyObject {
    func getWeatherOutput(date: String, minTemp: Double, maxTemp: Double, icon: String)
}
