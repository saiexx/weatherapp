//
//  ForecastViewModel.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import Foundation
import RxSwift

class ForecastViewModel {
    
    private var cityName: String
    
    private let getForecastUseCase = GetForecastUseCase()
    
    let forecastSubject: BehaviorSubject<Forecast?> = BehaviorSubject(value: nil)
    let alertSubject: PublishSubject<String> = PublishSubject()
    
    init(cityName: String) {
        self.cityName = cityName
        getCurrentWeather()
    }
    
    private func getCurrentWeather() {
        getForecastUseCase.execute(cityName: cityName) { forecast in
            self.forecastSubject.onNext(forecast)
        } onFailure: { error in
            self.alertSubject.onNext(error)
        }
    }
    
    func getCityName() -> String {
        return cityName
    }
}
