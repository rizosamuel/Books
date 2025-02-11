//
//  Router.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import UIKit

protocol Router { }

class BooksRouter: Router {
    
    private weak var splitVC: SplitViewController?
    private weak var sidebarVC: SidebarViewController?
    private weak var topTabBarVC: TopTabBarController?
    private lazy var homeVC = getHomeViewController()
    private lazy var libraryVC = getLibraryViewController()
    private lazy var storeVC = getStoreViewController()
    private lazy var searchVC = getSearchViewController()
    
    func getRootViewController() -> UIViewController {
        let splitVC = SplitViewController()
        setupTabs()
        let sidebarVC = getSidebarViewController()
        let secondaryVC = getSecondaryViewController()
        splitVC.setViewController(sidebarVC, for: .primary)
        splitVC.setViewController(secondaryVC, for: .secondary)
        self.splitVC = splitVC
        return splitVC
    }
    
    func getSidebarViewController() -> UIViewController {
        let sidebarVM = SidebarViewModel()
        let sidebarVC = SidebarViewController(viewModel: sidebarVM, router: self)
        self.sidebarVC = sidebarVC
        return UINavigationController(rootViewController: sidebarVC)
    }
    
    func getSecondaryViewController() -> UIViewController {
        let topTabBarVM = TopTabBarViewModel()
        let topTabBarVC = TopTabBarController(viewModel: topTabBarVM, router: self)
        topTabBarVC.setChild(homeVC)
        self.topTabBarVC = topTabBarVC
        return UINavigationController(rootViewController: topTabBarVC)
    }
    
    func setupTabs() {
        homeVC = getHomeViewController()
        libraryVC = getLibraryViewController()
        storeVC = getStoreViewController()
    }
    
    func getHomeViewController() -> UIViewController {
        let apiService = GoogleAPIServiceImpl()
        let booksRepository = GoogleBooksRepositoryImpl(googleApiService: apiService)
        let bestsellerBooksUseCase = BestsellerBooksUseCaseImpl(repository: booksRepository)
        let trendingNowBooksUseCase = TrendingNowBooksUseCaseImpl(repository: booksRepository)
        let homeVM = HomeViewModel(bestsellerBooksUseCase: bestsellerBooksUseCase, trendingNowBooksUseCase: trendingNowBooksUseCase)
        let homeVC = HomeViewController(viewModel: homeVM, router: self)
        return UINavigationController(rootViewController: homeVC)
    }
    
    func getLibraryViewController() -> UIViewController {
        let libraryVM = LibraryViewModel()
        let libraryVC = LibraryViewController(viewModel: libraryVM, router: self)
        return UINavigationController(rootViewController: libraryVC)
    }
    
    func getStoreViewController() -> UIViewController {
        let storeVM = StoreViewModel()
        let storeVC = StoreViewController(viewModel: storeVM, router: self)
        return UINavigationController(rootViewController: storeVC)
    }
    
    func getSearchViewController() -> UIViewController {
        let apiService = GoogleAPIServiceImpl()
        let booksRepository = GoogleBooksRepositoryImpl(googleApiService: apiService)
        let bestsellerBooksUseCase = BestsellerBooksUseCaseImpl(repository: booksRepository)
        let searchBooksUseCase = SearchBooksUseCaseImpl(repository: booksRepository)
        let searchVM = SearchViewModel(bestsellerBooksUseCase: bestsellerBooksUseCase, searchBooksUseCase: searchBooksUseCase)
        let searchVC = SearchViewController(viewModel: searchVM, router: self)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func routeTo(_ item: MenuItem) {
        guard let splitVC, let topTabBarVC else { return }
        
        switch item {
        case .home:
            topTabBarVC.setChild(homeVC)
            topTabBarVC.setSegmentedControlIndex(to: 0)
        case .library:
            topTabBarVC.setChild(libraryVC)
            topTabBarVC.setSegmentedControlIndex(to: 1)
        case .store:
            topTabBarVC.setChild(storeVC)
            topTabBarVC.setSegmentedControlIndex(to: 2)
        case .search:
            topTabBarVC.setChild(searchVC)
            topTabBarVC.setSegmentedControlIndex(to: 3)
        }
        
        splitVC.collapseSidebar()
    }
    
    func routeToDetails(from parent: UIViewController, with book: Book) {
        let bookDetailsVM = BookDetailViewModel(book: book)
        let bookDetailsVC = BookDetailViewController(viewModel: bookDetailsVM, router: self)
        parent.navigationController?.pushViewController(bookDetailsVC, animated: true)
    }
}
