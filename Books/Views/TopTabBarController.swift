//
//  TopTabBarController.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

class TopTabBarController: UIViewController {
    
    private let viewModel: TopTabBarViewModel
    private let router: BooksRouter
    
    private let segmentedControl: UISegmentedControl = {
        let searchImage = UIImage(systemName: "magnifyingglass")!
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .regular))
        let control = UISegmentedControl(items: ["Home", "Library", "Store", searchImage])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    var currentChild: UIViewController?
    
    init(viewModel: TopTabBarViewModel, router: BooksRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
    }
    
    @objc private func tabChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: router.routeTo(.home)
        case 1: router.routeTo(.library)
        case 2: router.routeTo(.store)
        case 3: router.routeTo(.search)
        default: break
        }
    }
    
    func setChild(_ viewController: UIViewController) {
        guard viewController != currentChild else { return }
        
        currentChild?.view.removeFromSuperview()
        currentChild?.removeFromParent()
        
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        currentChild = viewController
    }
    
    func setSegmentedControlIndex(to value: Int) {
        guard value >= 0 && value < segmentedControl.numberOfSegments else { return }
        
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.segmentedControl.selectedSegmentIndex = value
        }
    }
}
