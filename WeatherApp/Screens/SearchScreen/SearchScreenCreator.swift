//
//  SearchScreenCreator.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

struct SearchScreenCreator {
    var viewController: SearchScreenViewController {
        let manager: HttpClient = HttpClientImpl.shared
        let service: SearchNetworkService = SearchNetworkServiceImpl(manager: manager)
        let viewModel: SearchScreenViewModel = SearchScreenViewModelImpl(service: service)
        let viewController = SearchScreenViewController(viewModel: viewModel)
        return viewController
    }
}
