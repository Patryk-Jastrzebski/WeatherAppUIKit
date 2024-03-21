//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation
import CoreLocation
import Network

private extension String {
    static let networkMonitor = "NetworkMonitor"
    static let defaultErrorLocationMessage = "No access to the user's location"
}

protocol SearchScreenViewModel: SearchServiceable, Debouncable {
    var searchWorkItem: DispatchWorkItem? { get set }
}

final class SearchScreenViewModelImpl: NSObject, SearchScreenViewModel, CLLocationManagerDelegate {
    let service: SearchNetworkService
    private let locationManager = CLLocationManager()
    private let monitor = NWPathMonitor()
    
    var currentWeatherForSearch: Weather?
    var currentWeatherForUserLocation: Weather?
    
    var searchWorkItem: DispatchWorkItem?
    
    var searchText: String = "" {
        didSet {
            debounceWith { [weak self] in
                self?.getWeatherForSearchPhraseWithTask()
            }
        }
    }
    
    weak var delegate: DataLoadableDelegate?
    
    init(service: SearchNetworkService = SearchNetworkServiceImpl()) {
        self.service = service
        super.init()
        locationManager.delegate = self
    }
    
    private func getWeatherForSearchPhraseWithTask() {
        Task { @MainActor in
            await getWeatherForSearchPhrase()
        }
    }
    
    private func getWeatherForUserLocationWithTask(for location: CLLocationCoordinate2D?) {
        Task { @MainActor in
            await getWeatherForUserLocation(for: location)
        }
    }
    
    private func requestLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeatherForUserLocationWithTask(for: locations.first?.coordinate)
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.handleTitleError(shouldBeShown: true, .defaultErrorLocationMessage)
    }
}
