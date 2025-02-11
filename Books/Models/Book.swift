//
//  Book.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

struct Book: Codable {
    let title: String
    let authors: [String]
    let pageCount: Int
    let language: String
    let image: String
}
