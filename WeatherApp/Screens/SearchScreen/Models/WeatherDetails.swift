//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 20/03/2024.
//

import Foundation

struct WeatherDetails: Codable {
    let id: Int
    let mainDescription: String?
    let description: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case mainDescription = "main"
        case description
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mainDescription = try container.decodeIfPresent(String.self, forKey: .mainDescription)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        icon = try container.decodeIfPresent(String.self, forKey: .icon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(mainDescription, forKey: .mainDescription)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
}
