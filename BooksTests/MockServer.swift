//
//  MockServer.swift
//  Books
//
//  Created by Rijo Samuel on 08/02/25.
//

import XCTest

class MockServer: URLProtocol {
    static var mockResponse: (Data?, URLResponse?, Error?)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let (data, response, error) = MockServer.mockResponse else { return }
        
        if let error = error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
}
