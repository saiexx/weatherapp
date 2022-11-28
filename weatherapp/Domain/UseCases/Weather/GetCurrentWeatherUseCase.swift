//
//  GetCurrentWeatherUseCase.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation

final class GetCurrentWeatherUseCase {
    private let weatherRepository = WeatherRepository()
    
    func execute(cityName: String, onSuccess: @escaping (CurrentWeather) -> (), onFailure: @escaping ((String) -> Void)) {
        weatherRepository.getCurrentWeather(cityName: cityName) { result in
            onSuccess(result)
        } onFailure: { error in
            onFailure(error)
        }

    }
}
