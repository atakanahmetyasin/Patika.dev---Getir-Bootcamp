//
//  WeatherModel.swift
//  WeatherAppMVVM
//
//  Created by Ahmet Yasin Atakan on 2.04.2024.
//


import Foundation

// MARK: - Dictionary
struct WeatherModel: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String
    let tempC: Int
    let condition: Condition
    let windKph: Double
    let windDir: String
    let humidity, cloud: Int
    let feelslikeC, gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]
}

// MARK: - Astro
struct Astro: Codable {
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC, avgtempC, maxwindKph: Double
    let avgvisKM: Double
    let avghumidity, dailyChanceOfRain, dailyChanceOfSnow: Int
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case maxwindKph = "maxwind_kph"
        case avgvisKM = "avgvis_km"
        case avghumidity
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let condition: Astro
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

