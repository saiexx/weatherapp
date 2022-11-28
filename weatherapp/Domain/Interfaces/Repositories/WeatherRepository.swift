//
//  WeatherRepositories.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation

final class WeatherRepository {
    let weatherService = WeatherService()
    
    func getCurrentWeather(cityName: String,
                           onSuccess: @escaping (CurrentWeather) -> (),
                           onFailure: @escaping ((String) -> Void)) {
        weatherService.getCurrentWeather(cityName: cityName) { currentWeather in
            if let currentWeather = currentWeather {
                onSuccess(currentWeather)
            } else {
                onFailure("Something went wrong - no data")
            }
        } onFailure: { error in
            onFailure(error)
        }
    }
    
    func getForecast(cityName: String,
                     onSuccess: @escaping (Forecast) -> (),
                     onFailure: @escaping ((String) -> Void)) {
        weatherService.getForecast(cityName: cityName) { forecast in
            if let forecast = forecast {
                onSuccess(forecast)
            } else {
                onFailure("Something went wrong - no data")
            }
        } onFailure: { error in
            onFailure(error)
        }
    }
}
