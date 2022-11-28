//
//  TemperatureConverter.swift
//  weatherapp
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import Foundation

enum degreeType { case celsius, farenheit }

class TemperatureConverter {
    
    static func convertDegree(kelvin: Double, to degreeType: degreeType) -> Double {
        switch degreeType {
        case .celsius:
            return kelvin - 273.15
        case .farenheit:
            return ((kelvin - 273.15) * (9/5)) + 32
        }
    }
}
