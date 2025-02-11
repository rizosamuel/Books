//
//  SearchResultsViewController.swift
//  Books
//
//  Created by Rijo Samuel on 05/02/25.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didSelectBook(_ book: Book)
}

class SearchResultsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var books: [Book] = []
    weak var delegate: SearchResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        view.addSubview(tableView)
        constrainTable()
    }
    
    private func constrainTable() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func update(with books: [Book]) {
        DispatchQueue.main.async { [weak self] in
            self?.books = books
            self?.tableView.reloadData()
        }
    }
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectBook(book)
        }
    }
}
