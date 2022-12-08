//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Kosei Ban on 2022-11-05.
//

import SwiftUI

enum WeatherModel: String {
    case clear = "sun.max"
    case cloudy = "cloud"
    case rainy = "cloud.rain"
    case stormy = "cloud.bolt.rain"
    case sunny = "sun.max.fill"
    case tornado = "cloud.sun.bolt"
    case windy = "wind"
}

struct Forecast: Identifiable {
    var id = UUID()
    var date: Date
    var weather: WeatherModel
    var probability: Int
    var temperature: Int
    var high: Int
    var low: Int
    var location: String
    
    var icon: String {
        switch weather {
        case .clear:
            return "sun.max"
        case .cloudy:
            return "cloud"
        case .rainy:
            return "cloud.rain"
        case .stormy:
            return "cloud.bolt.rain"
        case .sunny:
            return "sun.max"
        case .tornado:
            return "cloud.sun.bolt"
        case .windy:
            return "wind"
        }
    }
}

extension Forecast {
    
    static let cities: [Forecast] = [
        Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .windy, probability: 0, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
        Forecast(date: .now, weather: .stormy, probability: 0, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
        Forecast(date: .now, weather: .tornado, probability: 0, temperature: 23, high: 26, low: 16, location: "Tennessee, United States"),
        Forecast(date: .now, weather: .sunny, probability: 0, temperature: 23, high: 26, low: 16, location: "Oosaka, Japan"),
        Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .windy, probability: 0, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
        Forecast(date: .now, weather: .stormy, probability: 0, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
        Forecast(date: .now, weather: .tornado, probability: 0, temperature: 23, high: 26, low: 16, location: "Tennessee, United States"),
        Forecast(date: .now, weather: .sunny, probability: 0, temperature: 23, high: 26, low: 16, location: "Oosaka, Japan"),
        Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .windy, probability: 0, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
        Forecast(date: .now, weather: .stormy, probability: 0, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
        Forecast(date: .now, weather: .tornado, probability: 0, temperature: 23, high: 26, low: 16, location: "Tennessee, United States"),
        Forecast(date: .now, weather: .sunny, probability: 0, temperature: 23, high: 26, low: 16, location: "Oosaka, Japan"),
        Forecast(date: .now, weather: .rainy, probability: 0, temperature: 19, high: 24, low: 18, location: "Montreal, Canada"),
        Forecast(date: .now, weather: .windy, probability: 0, temperature: 20, high: 21, low: 19, location: "Toronto, Canada"),
        Forecast(date: .now, weather: .stormy, probability: 0, temperature: 13, high: 16, low: 8, location: "Tokyo, Japan"),
        Forecast(date: .now, weather: .tornado, probability: 0, temperature: 23, high: 26, low: 16, location: "Tennessee, United States"),
        Forecast(date: .now, weather: .sunny, probability: 0, temperature: 23, high: 26, low: 16, location: "Oosaka, Japan")
    ]
}
