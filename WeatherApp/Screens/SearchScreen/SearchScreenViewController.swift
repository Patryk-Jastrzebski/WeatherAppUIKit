//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created by Patryk Jastrzębski on 17/03/2024.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: SearchScreenViewModel
    
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
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(cell: WeatherTableViewCell.self)
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension SearchScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: WeatherTableViewCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
}
