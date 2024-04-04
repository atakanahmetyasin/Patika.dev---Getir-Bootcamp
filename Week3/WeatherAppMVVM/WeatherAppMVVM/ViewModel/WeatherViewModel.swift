//
//  WeatherViewModel.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//

import Foundation

class WeatherViewModel {
    var reloadDataDelegate: (() -> Void)?
    private let service: NetworkManagerProtocol
    var weatherModel: WeatherModel?
    var forecastArray: [Forecastday] = []
    weak var output: NetworkManagerOutputProtocol?
    
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    func getWeatherData(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseURL)/\(Constants.forecast)?key=\(Constants.APIKey)&q=\(latitude),\(longitude)&days=7") else {
            print(NetworkError.InvalidURL)
            return
        }
        service.fetchData(url: url) { [weak self] (result: Result<WeatherModel, NetworkError>) in
            switch result {
            case .success(let data):
                self?.weatherModel = data
                self?.reloadDataDelegate?()
                self?.forecastArray = data.forecast.forecastday
                let forecastDay = data.forecast.forecastday
//                if let forecast = forecastDay.first {
//                    self?.output?.getWeatherOutput(date: forecast.date,
//                                                  minTemp: forecast.day.mintempC,
//                                                  maxTemp: forecast.day.maxtempC,
//                                                  icon: forecast.day.condition.icon)
//                }
                    for i in 0..<forecastDay.count {
                        self?.output?.getWeatherOutput(date: forecastDay[i].date,
                                                       minTemp: forecastDay[i].day.mintempC,
                                                       maxTemp: forecastDay[i].day.maxtempC,
                                                       icon: forecastDay[i].day.condition.icon)
                    }

            case .failure(let error):
                self?.output?.getWeatherOutput(date: "Error", minTemp: 0, maxTemp: 0, icon: "Error")
                print("Error: ", error)
            }
        }
    }
}
