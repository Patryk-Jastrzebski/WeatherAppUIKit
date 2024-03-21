//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    private let spinner = UIActivityIndicatorView(style: .medium)
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: SearchScreenViewModel
    
    init(viewModel: SearchScreenViewModel = SearchScreenViewModelImpl()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Weathers"
        tableView.register(cell: WeatherInfoTableViewCell.self)
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    private func setupView() {
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    func spinnerVisible(_ shouldBeVisible: Bool) {
        _ = shouldBeVisible ? spinner.startAnimating() : spinner.stopAnimating()
    }
}

extension SearchScreenViewController: DataLoadableDelegate {
    @MainActor func handleError(_ shouldBeShown: Bool, errorDescription: String?) {
        
    }
    
    @MainActor func handleLoading(_ shouldBeShown: Bool) {
        spinnerVisible(shouldBeShown)
    }
    
    @MainActor func didUpdateWeatherData() {
        tableView.reloadData()
    }
}

extension SearchScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherInfoTableViewCell()
        let weatherData = viewModel.getWeatherForIndex(indexPath.row)
        cell.configure(with: weatherData)
        return cell
    }
}

extension SearchScreenViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}
