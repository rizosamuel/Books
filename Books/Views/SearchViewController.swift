//
//  SearchViewController.swift
//  Books
//
//  Created by Rijo Samuel on 05/02/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private weak var router: BooksRouter?
    private var searchController: UISearchController!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        return table
    }()
    
    init(viewModel: SearchViewModel, router: BooksRouter? = nil) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        setupSearchController()
        setupTableView()
        fetchTrendingSearches()
    }
    
    private func setupSearchController() {
        let resultsVC = SearchResultsViewController()
        resultsVC.delegate = self
        searchController = UISearchController(searchResultsController: resultsVC)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        tableView.tableHeaderView = searchController.searchBar
        tableView.isScrollEnabled = false
    }
    
    private func fetchTrendingSearches() {
        viewModel.getBestsellerBooks { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trendingSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = viewModel.trendingSearches[indexPath.row]
        config.image = UIImage(systemName: "magnifyingglass")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .regular))
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trending"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = viewModel.trendingSearches[indexPath.row]
        searchController.searchBar.text = query
        searchController.isActive = true
        
        if let resultsVC = searchController.searchResultsController as? SearchResultsViewController {
            viewModel.searchBooks(with: query) { [weak self] in
                guard let self else { return }
                resultsVC.update(with: self.viewModel.searchResultBooks)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text, !query.isEmpty,
           let resultsVC = searchController.searchResultsController as? SearchResultsViewController {
            viewModel.searchBooks(with: query) { [weak self] in
                guard let self else { return }
                resultsVC.update(with: self.viewModel.searchResultBooks)
            }
        }
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didSelectBook(_ book: Book) {
        router?.routeToDetails(from: self, with: book)
    }
}
