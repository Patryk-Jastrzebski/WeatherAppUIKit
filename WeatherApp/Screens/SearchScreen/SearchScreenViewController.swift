//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

private extension String {
    static let error = "Error"
    static let defaultMessage = "Oops... something went wrong..."
    static let empty = ""
}

class SearchScreenViewController: UIViewController {
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private let alert = UIAlertController(title: .error,
                                          message: .defaultMessage,
                                          preferredStyle: .actionSheet)
    
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
        setupErrorAlert()
    }
    
    private func setupView() {
        navigationItem.setTitle(title: "WeatherApp", subtitle: "")
        tableView.register(cell: WeatherInfoTableViewCell.self)
        tableView.dataSource = self
        viewModel.delegate = self
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    private func spinnerVisible(_ shouldBeVisible: Bool) {
        _ = shouldBeVisible ? spinner.startAnimating() : spinner.stopAnimating()
    }
    
    private func setupErrorAlert() {
        alert.addAction(UIAlertAction(title: "OK", style: .default))
    }
}

extension SearchScreenViewController: DataLoadableDelegate {
    @MainActor func handleTitleError(shouldBeShown: Bool, _ errorMessage: String) {
        if shouldBeShown {
            navigationItem.setTitle(title: "WeatherApp", subtitle: errorMessage)
        } else {
            navigationItem.setTitle(title: "WeatherApp", subtitle: .empty)
        }
    }
    
    @MainActor func handleError(_ errorDescription: String?) {
        if let errorDescription {
            alert.message = errorDescription
        }
        self.present(alert, animated: true, completion: nil)
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
        cell.selectionStyle = .none
        return cell
    }
}

extension SearchScreenViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}

extension UINavigationItem {
    func setTitle(title: String, subtitle: String) {
        
        let one = UILabel()
        one.text = title
        one.font = UIFont.systemFont(ofSize: 17)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12)
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        
        self.titleView = stackView
    }
}
