//
//  CurrentWeatherViewModel.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation
import RxSwift


class CurrentWeatherViewModel {
    
    private let getCurrentWeatherUseCase = GetCurrentWeatherUseCase()
    
    let currentWeatherSubject: BehaviorSubject<CurrentWeather?> = BehaviorSubject(value: nil)
    let navigateToForecastViewController: PublishSubject<Any?> = PublishSubject()
    let alertSubject: PublishSubject<String> = PublishSubject()
    
    private var currentCityName = ""
    
    func getCurrentWeather(cityName: String) {
        getCurrentWeatherUseCase.execute(cityName: cityName) { currentWeather in
            self.currentCityName = currentWeather.name
            self.currentWeatherSubject.onNext(currentWeather)
        } onFailure: { error in
            self.alertSubject.onNext(error)
        }
    }
    
    func getCityName() -> String {
        return currentCityName
    }
    
    func prepareForNavigateToForecastViewController() {
        if !currentCityName.isEmpty {
            do {
                if try currentWeatherSubject.value() == nil {
                    alertSubject.onNext("City not found")
                    return
                }
            } catch {
                print(error)
                return
            }
            navigateToForecastViewController.onNext(nil)
            return
        }
        alertSubject.onNext("City not found")
    }
}
