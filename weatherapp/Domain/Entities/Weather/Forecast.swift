//
//  Forecast.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import Foundation

struct Forecast: Decodable {
    let list: [DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case list
    }
}

struct DailyForecast: Decodable {
    let time: Date
    let temperature: Double
    let humidity: Double
    let iconImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather
    }
    
    struct Weather: Decodable {
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let humidity: Double
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let weather = try container.decode([Weather].self, forKey: .weather)
        let main = try container.decode(Main.self, forKey: .main)
        
        let timeStamp = try container.decode(Int.self, forKey: .dt)
        
        self.time = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        self.temperature = main.temp
        self.humidity = main.humidity
        self.iconImageUrl = "https://openweathermap.org/img/wn/\(weather.first!.icon)@2x.png"
    }
}
