//
//  CurrentWeatherViewController.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import UIKit
import RxSwift
import Kingfisher

class CurrentWeatherViewController: UIViewController, AlertAble {
    
    var viewModel: CurrentWeatherViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureSwitcherButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    private var temperatureInKelvin: Double = 0
    private var currentDegreeType: degreeType = .celsius

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CurrentWeatherViewModel()
        setUpUI()
        subscribeToViewModel()
    }
    
    private func setUpUI() {
        currentWeatherView.isHidden = true
        
        weatherImage.layer.cornerRadius = weatherImage.frame.width/2
    }
    
    private func subscribeToViewModel() {
        viewModel.currentWeatherSubject.subscribe { currentWeather in
            if let currentWeather = currentWeather.element {
                if let currentWeather = currentWeather {
                    self.currentWeatherView.isHidden    = false
                    
                    self.weatherImage.kf.setImage(with: URL(string: currentWeather.iconImageUrl))
                    self.cityNameTextField.text         = currentWeather.name
                    self.humidityLabel.text             = "\(currentWeather.humidity)%"
                    self.navigationBar.topItem?.title   = currentWeather.name
                    
                    self.temperatureInKelvin            = currentWeather.temperature
                    self.handleTemperature()
                } else {
                    self.currentWeatherView.isHidden    = true
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.navigateToForecastViewController.subscribe { _ in
            self.performSegue(withIdentifier: "toForecastViewController", sender: nil)
        }.disposed(by: disposeBag)
        
        viewModel.alertSubject.subscribe { errorMessage in
            self.showAlert(title: errorMessage, message: "Please try again later")
        }.disposed(by: disposeBag)
    }
    
    private func handleTemperature() {
        let temperature = TemperatureConverter.convertDegree(kelvin: temperatureInKelvin, to: currentDegreeType)
        var degreeSymbol = ""
        
        switch (currentDegreeType) {
        case .celsius: degreeSymbol = "°C"
        case .farenheit: degreeSymbol = "°F"
        }
        temperatureLabel.text = "\(temperature.rounded())\(degreeSymbol)"
        
        let convertToCelsiusText = "Convert to Celsius"
        let convertToFarenheitText = "Convert To Farenheit"
        
        temperatureSwitcherButton.setTitle((currentDegreeType == .celsius) ? convertToFarenheitText : convertToCelsiusText, for: .normal)
    }
    
    @IBAction private func convertTemperatureButtonDidTap(_ sender: UIButton) {
        switch (currentDegreeType) {
        case .celsius: currentDegreeType = .farenheit
        case .farenheit: currentDegreeType = .celsius
        }
        handleTemperature()
    }
    
    @IBAction private func searchButtonDidTap(_ sender: UIButton) {
        let searchParam = cityNameTextField.text ?? ""
        self.view.endEditing(true)
        viewModel.getCurrentWeather(cityName: searchParam)
    }
    
    @IBAction private func forecastButtonDidTap(_ sender: UIBarButtonItem) {
        viewModel.prepareForNavigateToForecastViewController()
    }
}

extension CurrentWeatherViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toForecastViewController",
           let destinationVC = segue.destination as? ForecastViewController {
            destinationVC.viewModel = ForecastViewModel(cityName: viewModel.getCityName())
        }
    }
}
