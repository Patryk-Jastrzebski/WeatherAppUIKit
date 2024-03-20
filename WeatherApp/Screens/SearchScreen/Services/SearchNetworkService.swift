//
//  SearchNetworkService.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 20/03/2024.
//

import Foundation

protocol SearchNetworkService {
    func getWeatherInfoWithCity(_ city: String) async throws -> Weather
    func getWeatherInfoByCoordinates(lat: Double, lon: Double) async throws -> Weather
}

final class SearchNetworkServiceImpl: BaseNetworking, SearchNetworkService {
    func getWeatherInfoWithCity(_ city: String) async throws -> Weather {
        let request = HttpRequest(url: getBaseUrlWithVersion(with: .weather) + "q=\(city)",
                                  method: .get)
        return try await perform(request)
    }
    
    func getWeatherInfoByCoordinates(lat: Double, lon: Double) async throws -> Weather {
        let request = HttpRequest(url: getBaseUrlWithVersion(with: .weather) + "lat=\(lat)&lon=\(lon)",
                                  method: .get)
        return try await perform(request)
    }
}
