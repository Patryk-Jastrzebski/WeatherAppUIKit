//
//  SearchScreenCreator.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import Foundation

struct SearchScreenCreator {
    var viewController: SearchScreenViewController {
        let viewModel: SearchScreenViewModel = SearchScreenViewModelImpl()
        let viewController = SearchScreenViewController(viewModel: viewModel)
        return viewController
    }
}
