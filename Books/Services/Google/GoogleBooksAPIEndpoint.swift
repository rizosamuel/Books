//
//  APIEndpoint.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import Foundation

enum GoogleBooksAPIEndpoint {
    static let API_KEY = "AIzaSyB4K3tp3CyuGUMTgxtSjiJn1uDYLzNa--Q"
    static let BASE_URL = "https://www.googleapis.com/books/v1"
    
    case trendingNow
    case bestsellers
    case search(query: String)
}

extension GoogleBooksAPIEndpoint {
    var url: URL? {
        switch self {
        case .trendingNow:
            /// https://www.googleapis.com/books/v1/volumes?q=trending&maxResults=10
            let path = GoogleBooksAPIEndpoint.BASE_URL + "/volumes?q=trending&maxResults=10"
            return URL(string: path)
        case .bestsellers:
            /// https://www.googleapis.com/books/v1/volumes?q=bestseller&maxResults=10
            let path = GoogleBooksAPIEndpoint.BASE_URL + "/volumes?q=bestseller&maxResults=10"
            return URL(string: path)
        case .search(let query):
            /// https://www.googleapis.com/books/v1/volumes?q=harry&maxResults=10
            let path = GoogleBooksAPIEndpoint.BASE_URL + "/volumes?q=\(query)&maxResults=10"
            return URL(string: path)
        }
    }
    
    var httpMethod: String {
        switch self {
        case .trendingNow, .bestsellers, .search:
            return "GET"
        }
    }
}
