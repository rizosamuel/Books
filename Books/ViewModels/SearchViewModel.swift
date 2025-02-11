//
//  SearchViewModel.swift
//  Books
//
//  Created by Rijo Samuel on 05/02/25.
//

class SearchViewModel {
    let title = "Search"
    let bestsellerBooksUseCase: BestsellerBooksUseCaseImpl
    let searchBooksUseCase: SearchBooksUseCaseImpl
    var trendingSearches: [String] = []
    var searchResultBooks: [Book] = []
    
    init(bestsellerBooksUseCase: BestsellerBooksUseCaseImpl, searchBooksUseCase: SearchBooksUseCaseImpl) {
        self.bestsellerBooksUseCase = bestsellerBooksUseCase
        self.searchBooksUseCase = searchBooksUseCase
    }
    
    func getBestsellerBooks(completion: @escaping () -> Void) {
        bestsellerBooksUseCase.execute { [weak self] result in
            switch result {
            case .success(let books):
                print("bestsellers", books)
                self?.trendingSearches = books.map { $0.title }
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func searchBooks(with query: String, completion: @escaping () -> Void) {
        searchBooksUseCase.execute(with: query) { [weak self] result in
            switch result {
            case .success(let books):
                print("search results", books)
                self?.searchResultBooks = books
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
}
