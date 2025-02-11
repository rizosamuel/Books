//
//  SidebarViewModel.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

enum MenuItem: String, CaseIterable {
    case home = "Home"
    case library = "Library"
    case store = "Store"
    case search = "Search"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .library: return "books.vertical.fill"
        case .store: return "storefront.fill"
        case .search: return "magnifyingglass"
        }
    }
}

struct SidebarViewModel {
    let title = "Books"
    let menuItems = MenuItem.allCases.filter { $0 != .search }
}
