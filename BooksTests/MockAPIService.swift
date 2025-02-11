//
//  MockAPIService.swift
//  Books
//
//  Created by Rijo Samuel on 08/02/25.
//

import XCTest
@testable import Books

class MockAPIService: APIService {
    
    typealias T = Bool
    
    var request: URLRequest?
    var session: URLSession?
    
    init(request: URLRequest?, session: URLSession?) {
        self.request = request
        self.session = session
    }
    
    func fetchData(completion: @escaping (Result<Bool, APIError>) -> Void) {
        fetch(completion: completion)
    }
}
