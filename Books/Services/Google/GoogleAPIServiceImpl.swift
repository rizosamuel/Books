//
//  GoogleAPIServiceImpl.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import Foundation

class GoogleAPIServiceImpl: APIService {
    
    typealias T = GoogleBooksResponse
    
    var request: URLRequest?
    var session: URLSession? = URLSession.shared
    
    func set(for endpoint: GoogleBooksAPIEndpoint, httpBodyObject: [String: Any] = [:]) {
        guard let url = endpoint.url else { return }
        request = URLRequest(url: url)
        request?.httpMethod = endpoint.httpMethod
        request?.httpBody = getHttpBody(from: httpBodyObject)
    }
    
    private func getHttpBody(from httpBodyObject: [String: Any]) -> Data? {
        guard !httpBodyObject.isEmpty else { return nil }
        
        do {
            let httpBody = try JSONSerialization.data(withJSONObject: httpBodyObject, options: .fragmentsAllowed)
            return httpBody
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchData(completion: @escaping (Result<GoogleBooksResponse, APIError>) -> Void) {
        fetch(completion: completion)
    }
}
