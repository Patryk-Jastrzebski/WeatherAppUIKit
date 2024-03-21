//
//  Double+Temperature.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation

private struct Constants {
    static let celsius = "°C"
}

extension Double {
    var kelvinToCelsius: Double {
        self - 273.15
    }
    
    var kelvinToCelsiusString: String {
        return String(format: "%.1f", kelvinToCelsius) + Constants.celsius
    }
}
