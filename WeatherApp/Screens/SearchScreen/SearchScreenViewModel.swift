//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

protocol SearchScreenViewModel {
    var searchText: String { get set }
    var currentWeatherForSearch: Weather? { get set }
    var currentWeatherForUserLocation: Weather? { get set }
}

final class SearchScreenViewModelImpl: SearchScreenViewModel {
    
    let service: SearchNetworkService
    
    var currentWeatherForSearch: Weather?
    var currentWeatherForUserLocation: Weather?
    var searchText: String = ""
    
    init(service: SearchNetworkService = SearchNetworkServiceImpl()) {
        self.service = service
    }
}
