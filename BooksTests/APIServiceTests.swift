//
//  APIServiceTests.swift
//  Books
//
//  Created by Rijo Samuel on 08/02/25.
//

import XCTest
@testable import Books

class APIServiceTests: XCTestCase {
    
    var mockUrl: URL!
    var sut: MockAPIService!
    
    override func setUp() {
        super.setUp()
        
        mockUrl = URL(string: "https://www.mock.com")!
        let request = URLRequest(url: mockUrl)
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockServer.self]
        let session = URLSession(configuration: config)
        sut = MockAPIService(request: request, session: session)
    }
    
    override func tearDown() {
        mockUrl = nil
        MockServer.mockResponse = nil
        sut = nil
        super.tearDown()
    }
    
    func test_apiService_success() {
        let expectation = expectation(description: "Success Response")
        let data = try? JSONEncoder().encode(true)
        let response = HTTPURLResponse(url: mockUrl, statusCode: 200, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        MockServer.mockResponse = (data, response, error)
        sut.fetchData { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success, true)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test_apiService_noDatafailure() {
        let expectation = expectation(description: "Failure Response")
        let data: Data? = nil
        let response: HTTPURLResponse? = HTTPURLResponse(url: mockUrl, statusCode: 200, httpVersion: nil, headerFields: nil)
        let error: Error? = nil
        MockServer.mockResponse = (data, response, error)
        sut.fetchData { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                print("error", error.type)
                XCTAssertTrue(error.type == "decoding error")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
