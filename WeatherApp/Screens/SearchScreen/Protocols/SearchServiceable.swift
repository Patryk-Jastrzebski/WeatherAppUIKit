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
    func getWeatherForUserLocationWithTask(for userLocation: CLLocationCoordinate2D?)
}

extension SearchServiceable {
    func getWeatherForSearchPhrase() async {
        await delegate?.fetchData(data: searchText,
                                  with: service.getWeatherInfoWithCity,
                                  successAction: { [weak self] response in
            self?.currentWeatherForSearch = response
        })
    }
    
    func getWeatherForUserLocationWithTask(for userLocation: CLLocationCoordinate2D?) {
        guard let userLocation else { return }
        Task {
            do {
                currentWeatherForUserLocation = try await service.getWeatherInfoByCoordinates(lat: userLocation.latitude,
                                                                                              lon: userLocation.longitude)
            } catch {
                log(error)
            }
        }
    }
}
