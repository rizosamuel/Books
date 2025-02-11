//
//  GoogleBooksResponse.swift
//  Books
//
//  Created by Rijo Samuel on 02/02/25.
//

import Foundation

// MARK: - Welcome
struct GoogleBooksResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind, id, etag: String
//    let selfLink: String
    let volumeInfo: VolumeInfo
//    let saleInfo: SaleInfo
//    let accessInfo: AccessInfo
//    let searchInfo: SearchInfo
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let country, viewability: String
    let embeddable, publicDomain: Bool
    let textToSpeechPermission: String
    let epub, pdf: Epub
    let webReaderLink: String
    let accessViewStatus: String
    let quoteSharingAllowed: Bool
}

// MARK: - Epub
struct Epub: Codable {
    let isAvailable: Bool
    let acsTokenLink: String
}

// MARK: - SaleInfo
struct SaleInfo: Codable {
    let country, saleability: String
    let isEbook: Bool
    let listPrice, retailPrice: SaleInfoListPrice
    let buyLink: String
    let offers: [Offer]
}

// MARK: - SaleInfoListPrice
struct SaleInfoListPrice: Codable {
    let amount: Double
    let currencyCode: String
}

// MARK: - Offer
struct Offer: Codable {
    let finskyOfferType: Int
    let listPrice, retailPrice: OfferListPrice
}

// MARK: - OfferListPrice
struct OfferListPrice: Codable {
    let amountInMicros: Int
    let currencyCode: String
}

// MARK: - SearchInfo
struct SearchInfo: Codable {
    let textSnippet: String
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate, description: String?
//    let industryIdentifiers: [IndustryIdentifier]
//    let readingModes: ReadingModes
    let pageCount: Int
    let printType: String
    let categories: [String]?
    let maturityRating: String
//    let allowAnonLogging: Bool
//    let contentVersion: String
//    let panelizationSummary: PanelizationSummary
    let imageLinks: ImageLinks
    let language: String
//    let previewLink: String
//    let infoLink, canonicalVolumeLink: String
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}

// MARK: - IndustryIdentifier
struct IndustryIdentifier: Codable {
    let type, identifier: String
}

// MARK: - PanelizationSummary
struct PanelizationSummary: Codable {
    let containsEpubBubbles, containsImageBubbles: Bool
}

// MARK: - ReadingModes
struct ReadingModes: Codable {
    let text, image: Bool
}

// MARK: - Convert Books response to Books
extension GoogleBooksResponse {
    var toBooks: [Book] {
        self.items.map {
            let title = $0.volumeInfo.title
            let authors = $0.volumeInfo.authors ?? []
            let pageCount = $0.volumeInfo.pageCount
            let language = $0.volumeInfo.language
            let image = $0.volumeInfo.imageLinks.thumbnail.replacingOccurrences(of: "http://", with: "https://")
            return Book(title: title, authors: authors, pageCount: pageCount, language: language, image: image)
        }
    }
}
