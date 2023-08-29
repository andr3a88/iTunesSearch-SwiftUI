//
//  Album.swift
//  iTunes-SwiftUI
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

// MARK: - AlbumResult

struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Album

struct Album: Codable, Identifiable {
    
    let wrapperType: String
    let collectionType: String
    let artistID: Int
    let collectionID: Int
    let amgArtistID: Int?
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewURL: String?
    let collectionViewURL: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String?
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String

    var id: Int {
        collectionID
    }

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
}
