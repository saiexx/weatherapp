//
//  TemperatureConverter.swift
//  weatherappTests
//
//  Created by Kasidid Wachirachai on 29/11/22.
//

import XCTest
@testable import weatherapp

final class TemperatureConverterTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKelvinConverter() throws {
        
        let firstKelvinValue = 273.15
        
        let celsiusFirstValue = TemperatureConverter.convertDegree(kelvin: firstKelvinValue, to: .celsius)
        let farenheitFirstValue = TemperatureConverter.convertDegree(kelvin: firstKelvinValue, to: .farenheit)
        
        XCTAssertEqual(0.0, celsiusFirstValue, "celsius first value incorrect \(celsiusFirstValue)")
        XCTAssertEqual(32.0, farenheitFirstValue, "farenheit first value incorrect \(farenheitFirstValue)")
        
        let secondKelvinValue = 298.15
        
        let celsiusSecondValue = TemperatureConverter.convertDegree(kelvin: secondKelvinValue, to: .celsius)
        let farenheitSecondValue = TemperatureConverter.convertDegree(kelvin: secondKelvinValue, to: .farenheit)
        
        XCTAssertEqual(25.0, celsiusSecondValue, "celsius second value incorrect \(celsiusSecondValue)")
        XCTAssertEqual(77.0, farenheitSecondValue, "farenheit second value incorrect \(farenheitSecondValue)")
        
        let thirdKelvinValue = 373.15
        
        let celsiusThirdValue = TemperatureConverter.convertDegree(kelvin: thirdKelvinValue, to: .celsius)
        let farenheitThirdValue = TemperatureConverter.convertDegree(kelvin: thirdKelvinValue, to: .farenheit)
        
        XCTAssertEqual(100.0, celsiusThirdValue, "celsius third value incorrect \(celsiusThirdValue)")
        XCTAssertEqual(212.0, farenheitThirdValue, "farenheit third value incorrect \(farenheitThirdValue)")
        
    }

}
