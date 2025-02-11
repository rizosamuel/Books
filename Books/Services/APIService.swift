//
//  APIService.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import Foundation

enum APIError: Error {
    case invalidSession
    case invalidRequest
    case noData
    case maxRetriesReached(error: Error)
    case decodingError(error: Error)
    
    var type: String {
        switch self {
        case .invalidSession:
            return "invalid session"
        case .invalidRequest:
            return "invalid request"
        case .noData:
            return "no data"
        case .maxRetriesReached(let error):
            return "max retries reached"
        case .decodingError(let error):
            return "decoding error"
        }
    }
}

class APIRequestQueue {
    static let shared = OperationQueue()
    
    private init() {
        APIRequestQueue.shared.maxConcurrentOperationCount = 5
    }
}

protocol APIService: AnyObject {
    var request: URLRequest? { get set }
    var session: URLSession? { get }
    associatedtype T
    func fetch<T: Codable>(retryCount: Int, maxRetries: Int, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIService {
    
    private func updateRequestWithDefaultData() {
        request?.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
    
    func fetch<T: Codable>(retryCount: Int = 0, maxRetries: Int = 3, completion: @escaping (Result<T, APIError>) -> Void) {
        updateRequestWithDefaultData()
        
        guard let request else {
            completion(.failure(.invalidRequest))
            return
        }
        
        guard let session else {
            completion(.failure(.invalidSession))
            return
        }
        
        let operation = BlockOperation {
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request failed: \(error.localizedDescription) | Retry Attempt: \(retryCount)")
                    
                    if retryCount < maxRetries {
                        let delay = pow(2.0, Double(retryCount)) // Exponential backoff
                        DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                            self.fetch(retryCount: retryCount + 1, maxRetries: maxRetries, completion: completion)
                        }
                    } else {
                        completion(.failure(.maxRetriesReached(error: error)))
                    }
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error: error)))
                }
            }
            
            task.resume()
        }
        
        APIRequestQueue.shared.addOperation(operation)
    }
}
