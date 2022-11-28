//
//  GetForecastUseCase.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import Foundation

final class GetForecastUseCase {
    private let weatherRepository = WeatherRepository()
    
    func execute(cityName: String, onSuccess: @escaping (Forecast) -> (), onFailure: @escaping ((String) -> Void)) {
        weatherRepository.getForecast(cityName: cityName) { result in
            onSuccess(result)
        } onFailure: { error in
            onFailure(error)
        }
        
    }
}
