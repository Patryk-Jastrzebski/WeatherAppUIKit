//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 16/03/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case httpError
    case urlError
    case imageError
    case missingName
    case apiError(data: Data?)
}
