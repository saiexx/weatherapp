//
//  WeatherService.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation

class WeatherService {
    private let networkService = NetworkService.shared
    
    private let currentWeatherPath  = "/weather"
    private let forecastPath        = "/forecast"
    
    func getCurrentWeather(cityName: String,
                           onSuccess: @escaping (CurrentWeather?) -> (),
                           onFailure: @escaping (String) -> ()) {
        let params = ["q": cityName.replacingOccurrences(of: " ", with: "")].toParameterString()
        networkService.request(path: currentWeatherPath, body: nil, header: nil, param: params ,type: CurrentWeather.self) { result in
            onSuccess(result)
        } onFailure: { error in
            onFailure(error)
        }
    }
    
    func getForecast(cityName: String,
                           onSuccess: @escaping (Forecast?) -> (),
                           onFailure: @escaping (String) -> ()) {
        let params = ["q": cityName.replacingOccurrences(of: " ", with: "")].toParameterString()
        networkService.request(path: forecastPath, body: nil, header: nil, param: params ,type: Forecast.self) { result in
            onSuccess(result)
        } onFailure: { error in
            onFailure(error)
        }
    }
}
