//
//  BaseNetworking.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 16/03/2024.
//

import Foundation

enum APIVersion: String {
    case dev = "/2.5"
    case prd = "/3.0"
}

enum UrlFeaturePath: String {
    case weather = "/weather"
    case none = ""
}

class BaseNetworking {
    private let manager: HttpClient
    
    internal var baseUrl: String {
        let configuration = Environment.shared.configuration
        return "\(configuration.serverUrlProtocol)://\(configuration.serverUrlHost)\(APIVersion.dev.rawValue)"
    }
    
    internal func getBaseUrlWithVersion(with path: UrlFeaturePath, apiVersion: APIVersion = .dev) -> String {
        let configuration = Environment.shared.configuration
        // swiftlint:disable:next line_length
        return "\(configuration.serverUrlProtocol)://\(configuration.serverUrlHost)\(apiVersion.rawValue)\(path.rawValue)?appid=\(configuration.apiKey)&"
    }

    init(manager: HttpClient = HttpClientImpl.shared) {
        self.manager = manager
    }

    func perform<T: Codable>(_ request: HttpRequest) async throws -> T {
        do {
            return try await manager.perform(request)
        } catch {
            throw error
        }
    }
}
