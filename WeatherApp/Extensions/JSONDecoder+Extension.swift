//
//  JSONDecoder+Extension.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
