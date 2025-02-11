//
//  BooksUseCase.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

protocol BooksUseCase {
    func execute(completion: @escaping (Result<[Book], Error>) -> Void)
}

class BestsellerBooksUseCaseImpl: BooksUseCase {
    
    private let repository: BooksRepository
    
    init(repository: BooksRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Book], Error>) -> Void) {
        repository.getBestsellers(completion: completion)
    }
}

class TrendingNowBooksUseCaseImpl: BooksUseCase {
    
    private let repository: BooksRepository
    
    init(repository: BooksRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Book], Error>) -> Void) {
        repository.getTrendingNow(completion: completion)
    }
}

class SearchBooksUseCaseImpl: BooksUseCase {
    
    private let repository: BooksRepository
    var query = ""
    
    init(repository: BooksRepository) {
        self.repository = repository
    }
    
    func execute(with query: String, completion: @escaping (Result<[Book], any Error>) -> Void) {
        self.query = query
        execute(completion: completion)
    }
    
    func execute(completion: @escaping (Result<[Book], any Error>) -> Void) {
        repository.search(with: query, completion: completion)
    }
}
