//
//  WeatherUITableViewModel.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation

protocol WeatherUITableViewModel: AnyObject {
    var currentWeatherForSearch: Weather? { get set }
    var currentWeatherForUserLocation: Weather? { get set }
}

extension WeatherUITableViewModel {
    var numberOfRows: Int {
        let dataArray = [currentWeatherForUserLocation, currentWeatherForSearch].compactMap { $0 }
        return dataArray.count
    }
    
    func getWeatherForIndex(_ index: Int) -> Weather? {
        let dataArray = [currentWeatherForUserLocation, currentWeatherForSearch].compactMap { $0 }
        guard index >= 0 && index < dataArray.count else {
            return nil
        }
        return dataArray[index]
    }
}
