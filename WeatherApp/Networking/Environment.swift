//
//  Environment.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

enum EnvironmentError: Error {
    case defaultConfigurationFileMissing
}

struct Configuration: Codable {
    let name: String
    let serverUrlProtocol: String
    let serverUrlHost: String
    let serverUrlScheme: String
    let apiKey: String
}

class Environment {
    static let shared = Environment()
    
    var configuration: Configuration
    
    init() {
        self.configuration = Self.loadConfiguration()
    }
}

private extension Environment {
    private static func loadConfiguration(decoder: JSONDecoder = JSONDecoder(),
                                          fileManager: FileManager = FileManager()) -> Configuration {
        do {
            guard let defaultConfigurationFilePathUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
                throw EnvironmentError.defaultConfigurationFileMissing
            }
            let defaultConfigurationFileContent = try Data(contentsOf: defaultConfigurationFilePathUrl)
            let defaultConfiguration = try decoder.decode(Configuration.self, from: defaultConfigurationFileContent)
            return defaultConfiguration
        } catch {
            fatalError("Loading default configuration failed: \(error)")
        }
    }
}
