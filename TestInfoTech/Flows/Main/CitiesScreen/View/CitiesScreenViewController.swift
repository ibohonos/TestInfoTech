//
//  CitiesScreenViewController.swift
//  TestInfoTech
//
//  Created by Іван Богоносюк on 15.11.2022.
//

import UIKit

protocol CitiesScreenViewControllerProtocol: AnyObject {
    func didGetError(message: String?)
    func didGetCities(cities: [City])
}

class CitiesScreenViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var contentTableView: UITableView!
    
    // MARK: - Properties
    var presenter: CitiesScreenPresenterProtocol?
    private var dataSource: [City] = [] {
        didSet {
            contentTableView.reloadData()
        }
    }
    private let oddImage = "https://infotech.gov.ua/storage/img/Temp3.png"
    private let evenImage = "https://infotech.gov.ua/storage/img/Temp1.png"
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search city"
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseAppearance()
        setupTableContent()
        presenter?.neededToLoadCities()
    }
}

// MARK: - CitiesScreenViewControllerProtocol
extension CitiesScreenViewController: CitiesScreenViewControllerProtocol {
    func didGetError(message: String?) {
        presentError(message: message)
    }
    
    func didGetCities(cities: [City]) {
        dataSource = cities
    }
}

// MARK: - Private
private extension CitiesScreenViewController {
    func setupBaseAppearance() {
        title = "Cities"
        navigationItem.searchController = searchController
    }
    
    func setupTableContent() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        let cityCellNib = UINib(nibName: CityTableViewCell.identifier, bundle: nil)

        contentTableView.register(cityCellNib, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CitiesScreenViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeueCityCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.neededToShowCityScreen(dataSource[indexPath.item])
    }
}

// MARK: - Table helpers
private extension CitiesScreenViewController {
    func dequeueCityCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            fatalError("Error: no such cell with identifier \(CityTableViewCell.identifier)")
        }
        
        cell.setupCell(with: dataSource[indexPath.item], image: indexPath.item % 2 == 0 ? evenImage : oddImage)
        
        return cell
    }
}

// MARK: - UISearchResultsUpdating & UISearchControllerDelegate
extension CitiesScreenViewController: UISearchResultsUpdating & UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.neededToSearchCities(text: searchController.searchBar.text)
    }
}
