//
//  ForecastTableViewCell.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherImageView.layer.cornerRadius = weatherImageView.frame.width/2
    }
    
    func setCell(data: DailyForecast) {
        weatherImageView.kf.setImage(with: URL(string: data.iconImageUrl))
        humidityLabel.text = "\(data.humidity)%"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let formattedDate = formatter.string(from: data.time)
        timeLabel.text = formattedDate
        
        let celsius = TemperatureConverter.convertDegree(kelvin: data.temperature, to: .celsius)
        let farenheit = TemperatureConverter.convertDegree(kelvin: data.temperature, to: .farenheit)
        
        let temperatureText = "\(celsius.rounded())°C/\(farenheit.rounded())°F"
        temperatureLabel.text = temperatureText
    }
    
}
