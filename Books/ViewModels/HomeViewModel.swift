//
//  HomeViewModel.swift
//  Books
//
//  Created by Rijo Samuel on 01/02/25.
//

struct HomeSection {
    let title: String
    let books: [Book]
}

class HomeViewModel {
    let title = "Home"
    let bestsellerBooksUseCase: BestsellerBooksUseCaseImpl
    let trendingNowBooksUseCase: TrendingNowBooksUseCaseImpl
    
    var homeSections: [HomeSection] = []
    
    init(bestsellerBooksUseCase: BestsellerBooksUseCaseImpl, trendingNowBooksUseCase: TrendingNowBooksUseCaseImpl) {
        self.bestsellerBooksUseCase = bestsellerBooksUseCase
        self.trendingNowBooksUseCase = trendingNowBooksUseCase
    }
    
    func getBestsellerBooks(completion: @escaping () -> Void) {
        bestsellerBooksUseCase.execute { [weak self] result in
            switch result {
            case .success(let books):
                print("bestsellers", books)
                self?.homeSections.append(HomeSection(title: "Bestsellers", books: books))
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    func getTrendingNowBooks(completion: @escaping () -> Void) {
        trendingNowBooksUseCase.execute { [weak self] result in
            switch result {
            case .success(let books):
                print("trending now", books)
                self?.homeSections.append(HomeSection(title: "Trending Now", books: books))
            case .failure(let error):
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
    deinit {
        homeSections = []
    }
}
