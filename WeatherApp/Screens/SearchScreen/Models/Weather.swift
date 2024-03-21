//
//  Weather.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 20/03/2024.
//

import Foundation

struct Weather: Codable {
    let name: String
    let main: MainWeatherInfo?
    let details: [WeatherDetails]
    
    enum CodingKeys: String, CodingKey {
        case name
        case main
        case details = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        main = try container.decodeIfPresent(MainWeatherInfo.self, forKey: .main)
        details = try container.decode([WeatherDetails].self, forKey: .details)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encodeIfPresent(details, forKey: .details)
    }
}
