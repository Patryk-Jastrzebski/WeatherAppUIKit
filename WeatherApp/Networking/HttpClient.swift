//
//  HttpClient.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 16/03/2024.
//

import Foundation

protocol HttpClient {
    func perform<T: Decodable>(_ request: HttpRequest) async throws -> T
    func perform(imagePath: String) async throws -> Data
}

final class HttpClientImpl: HttpClient {
    static let shared = HttpClientImpl()

    private var session: URLSession
    private var locale: Locale

    private init(session: URLSession = .shared, locale: Locale = .current) {
        self.session = session
        self.locale = locale
    }

    func perform<T: Decodable>(_ request: HttpRequest) async throws -> T {
        guard var components = URLComponents(string: request.url) else {
            throw NetworkError.invalidURL
        }
        
        if request.method == .get && request.body == nil {
            components.queryItems = components.queryItems != nil ? components.queryItems : [URLQueryItem]()
            components.queryItems?.append(contentsOf: request.parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            })
        }

        guard let url = components.url else {
            throw NetworkError.httpError
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: urlRequest)
        _ = request.logRequest
        log(try? JSONSerialization.jsonObject(with: data))

        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.httpError
        }

        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }

    func perform(imagePath: String) async throws -> Data {
        guard let url = URL(string: imagePath) else {
            throw NetworkError.urlError
        }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.httpError
        }
        return data
    }
}

struct EmptyData: Codable {}
