//
//  CurrentWeather.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 28/11/22.
//

import Foundation

struct CurrentWeather: Decodable {
    
    let id: Int
    let name: String
    let temperature: Double
    let humidity: Double
    let iconImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, weather, main
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
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.temperature = main.temp
        self.humidity = main.humidity
        self.iconImageUrl = "https://openweathermap.org/img/wn/\(weather.first!.icon)@2x.png"
    }
}
