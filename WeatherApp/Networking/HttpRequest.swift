//
//  HttpRequest.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 16/03/2024.
//

import Foundation

typealias Parameters = [String: Any]
typealias Headers = [String: String]

class HttpRequest {
    let url: String
    let method: HttpMethod
    let parameters: Parameters
    let body: Data?

    init(url: String,
         method: HttpMethod,
         parameters: Parameters = [:],
         body: Data? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.body = body
    }
    
    var logRequest: Any? {
        if let body = body {
            log("""
\(self.method.rawValue.uppercased()) \(self.url)
\(body.getFormattedJSON())
""")
        } else {
            log("""
\(self.method.rawValue.uppercased()) \(url)
""")
        }
        return nil
    }
}
