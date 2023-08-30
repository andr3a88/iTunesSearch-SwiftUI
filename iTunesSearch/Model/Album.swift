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
    let releaseDate: String?
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

extension Album {

    static func mock() -> Album {
        Album(wrapperType: "collection", collectionType: "Album", artistID: 2, collectionID: 1, amgArtistID: 3,
              artistName: "Jack Johnson & Friends",
              collectionName: "Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)", collectionCensoredName: "",
              artistViewURL: nil, collectionViewURL: "https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4",
              artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
              artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
              collectionPrice: 8.99, collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")

    }
}
