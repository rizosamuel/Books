//
//  LibraryViewController.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

class LibraryViewController: UIViewController {
    private let viewModel: LibraryViewModel
    private weak var router: BooksRouter?
    
    init(viewModel: LibraryViewModel, router: BooksRouter) {
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
    }
}
