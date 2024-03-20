//
//  MainWeatherInfo.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 20/03/2024.
//

import Foundation

struct MainWeatherInfo: Codable {
    let temperature: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decodeIfPresent(Double.self, forKey: .temp)
        feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike)
        tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
        tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
        humidity = try container.decodeIfPresent(Double.self, forKey: .humidity)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temperature, forKey: .temp)
        try container.encodeIfPresent(feelsLike, forKey: .feelsLike)
        try container.encodeIfPresent(tempMin, forKey: .tempMin)
        try container.encodeIfPresent(tempMax, forKey: .tempMax)
        try container.encodeIfPresent(humidity, forKey: .humidity)
    }
}
