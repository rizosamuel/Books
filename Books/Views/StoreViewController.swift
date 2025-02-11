//
//  StoreViewController.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

class StoreViewController: UIViewController {
    
    private let viewModel: StoreViewModel
    private weak var router: BooksRouter?
    
    init(viewModel: StoreViewModel, router: BooksRouter) {
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
