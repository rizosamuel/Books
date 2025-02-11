//
//  BooksRepository.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

protocol BooksRepository {
    func getBestsellers(completion: @escaping (Result<[Book], Error>) -> Void)
    func getTrendingNow(completion: @escaping (Result<[Book], Error>) -> Void)
    func search(with query: String, completion: @escaping (Result<[Book], Error>) -> Void)
}

class GoogleBooksRepositoryImpl: BooksRepository {
    
    let googleApiService: GoogleAPIServiceImpl
    
    init(googleApiService: GoogleAPIServiceImpl) {
        self.googleApiService = googleApiService
    }
    
    func getBestsellers(completion: @escaping (Result<[Book], Error>) -> Void) {
        googleApiService.set(for: .bestsellers)
        googleApiService.fetchData { result in
            switch result {
            case .success(let booksResponse):
                let books = booksResponse.toBooks
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTrendingNow(completion: @escaping (Result<[Book], Error>) -> Void) {
        googleApiService.set(for: .trendingNow)
        googleApiService.fetchData { result in
            switch result {
            case .success(let booksResponse):
                let books = booksResponse.toBooks
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func search(with query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        googleApiService.set(for: .search(query: query))
        googleApiService.fetchData { result in
            switch result {
            case .success(let booksResponse):
                let books = booksResponse.toBooks
                completion(.success(books))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
