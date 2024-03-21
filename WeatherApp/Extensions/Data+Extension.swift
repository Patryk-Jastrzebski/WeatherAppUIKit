//
//  Data+Extension.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

extension Data {
    func getFormattedJSON() -> String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
           return String(decoding: jsonData, as: UTF8.self)
        }

        return ""
    }
    
    func getErrorMessage() -> String? {
        if let errorMessage = try? JSONDecoder.default.decode(ErrorMessage.self, from: self) {
            return errorMessage.message
        }
        return nil
    }

    private func pringJSONData(_ data: Data) {
        print(String(decoding: data, as: UTF8.self))
    }
}

struct ErrorMessage: Codable {
    let message: String?
}
