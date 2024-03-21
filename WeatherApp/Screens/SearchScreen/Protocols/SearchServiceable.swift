//
//  SearchServiceable.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 21/03/2024.
//

import Foundation
import CoreLocation

protocol SearchServiceable: AnyObject, WeatherUITableViewModel {
    var delegate: DataLoadableDelegate? { get set }
    var service: SearchNetworkService { get }
    var searchText: String { get set }
}

extension SearchServiceable {
    func getWeatherForSearchPhrase() async {
        guard !searchText.isEmpty else { return }
        await delegate?.fetchData(data: searchText,
                                  with: service.getWeatherInfoWithCity,
                                  successAction: { [weak self] response in
            self?.currentWeatherForSearch = response
            self?.delegate?.didUpdateWeatherData()
        })
    }
    
    func getWeatherForUserLocation(for userLocation: CLLocationCoordinate2D?) async {
        guard let userLocation else { return }
        await delegate?.fetchData(data: (userLocation.latitude, userLocation.longitude),
                                  with: service.getWeatherInfoByCoordinates,
                                  successAction: { [weak self] response in
            self?.currentWeatherForUserLocation = response
            self?.delegate?.didUpdateWeatherData()
        })
    }
}
