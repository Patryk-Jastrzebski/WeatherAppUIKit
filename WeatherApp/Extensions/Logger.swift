//
//  Logger.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

func log(_ items: Any...) {
    #if DEBUG
        debugPrint(items)
    #endif
}
