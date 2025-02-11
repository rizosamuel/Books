//
//  BookDetailViewController.swift
//  Books
//
//  Created by Rijo Samuel on 04/02/25.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    private let viewModel: BookDetailViewModel
    private weak var router: BooksRouter?
    
    init(viewModel: BookDetailViewModel, router: BooksRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.book.title
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
    }
}
