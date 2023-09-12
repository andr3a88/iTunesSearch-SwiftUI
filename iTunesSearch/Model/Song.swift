//
//  Song.swift
//  iTunes-SwiftUI
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

// MARK: - SongResult

struct SongResult: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Song
struct Song: Codable, Identifiable, Equatable, Hashable {
    let wrapperType: String
    let artistID: Int
    let collectionID: Int
    let trackID: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let artistViewURL: String
    let collectionViewURL: String
    let trackViewURL: String
    let previewURL: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String?
    let trackCount: Int
    let trackNumber: Int
    let trackTimeMillis: Int?
    let country: String
    let currency: String
    let primaryGenreName: String
    let collectionArtistName: String?

    let id = UUID()

    enum CodingKeys: String, CodingKey {
        case wrapperType
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName
        case collectionName
        case trackName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, collectionArtistName
    }

    init(wrapperType: String, artistID: Int, collectionID: Int, id: Int, artistName: String, collectionName: String,
         trackName: String, artistViewURL: String, collectionViewURL: String, trackViewURL: String, previewURL: String,
         artworkUrl30: String, artworkUrl60: String, artworkUrl100: String,
         collectionPrice: Double?, trackPrice: Double?, releaseDate: String, trackCount: Int, trackNumber: Int,
         trackTimeMillis: Int, country: String, currency: String, primaryGenreName: String, collectionArtistName: String?) {
        self.wrapperType = wrapperType
        self.trackID = id
        self.artistID = artistID
        self.collectionID = collectionID
        self.collectionName = collectionName
        self.collectionViewURL = collectionViewURL
        self.collectionArtistName = collectionArtistName
        self.previewURL = previewURL

        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.currency = currency
        self.country = country
        self.primaryGenreName = primaryGenreName

        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl100
        self.artistViewURL = artistViewURL
        self.artistName = artistName

        self.trackName = trackName
        self.trackCount = trackCount
        self.trackNumber = trackNumber
        self.trackTimeMillis = trackTimeMillis
        self.trackViewURL = trackViewURL
        self.releaseDate = releaseDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wrapperType = try container.decode(String.self, forKey: .wrapperType)
        self.artistID = try container.decode(Int.self, forKey: .artistID)
        self.collectionID = try container.decode(Int.self, forKey: .collectionID)
        self.trackID = try container.decodeIfPresent(Int.self, forKey: .trackID) ?? 0
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.collectionName = try container.decode(String.self, forKey: .collectionName)
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        self.artistViewURL = try container.decodeIfPresent(String.self, forKey: .artistViewURL) ?? ""
        self.collectionViewURL = try container.decodeIfPresent(String.self, forKey: .collectionViewURL) ?? ""
        self.trackViewURL = try container.decodeIfPresent(String.self, forKey: .trackViewURL) ?? ""
        self.previewURL = try container.decodeIfPresent(String.self, forKey: .previewURL) ?? ""
        self.artworkUrl30 = try container.decodeIfPresent(String.self, forKey: .artworkUrl30) ?? ""
        self.artworkUrl60 = try container.decode(String.self, forKey: .artworkUrl60)
        self.artworkUrl100 = try container.decode(String.self, forKey: .artworkUrl100)
        self.collectionPrice = try container.decodeIfPresent(Double.self, forKey: .collectionPrice)
        self.trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.trackCount = try container.decode(Int.self, forKey: .trackCount)
        self.trackNumber = try container.decodeIfPresent(Int.self, forKey: .trackNumber) ?? 0
        self.trackTimeMillis = try container.decodeIfPresent(Int.self, forKey: .trackTimeMillis)
        self.country = try container.decode(String.self, forKey: .country)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.primaryGenreName = try container.decode(String.self, forKey: .primaryGenreName)
        self.collectionArtistName = try container.decodeIfPresent(String.self, forKey: .collectionArtistName)
    }
}

extension Song {

    static func mock(trackID: Int = 1) -> Song {
        Song(wrapperType: "Song",
             artistID: 1, 
             collectionID: 579836258,
             id: trackID,
             artistName: "Jack Johnson \(trackID)",
             collectionName: "Jack Johnson and Friends",
             trackName: "Upside Down \(trackID)",
             artistViewURL: "",
             collectionViewURL: "",
             trackViewURL: "https://music.apple.com/us/album/upside-down/1469577723?i=1469577741&uo=4", 
             previewURL: "https://is3-ssl.mzstatic.com",
             artworkUrl30: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/30x30bb.jpg",
             artworkUrl60: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/60x60bb.jpg",
             artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/08/11/d2/0811d2b3-b4d5-dc22-1107-3625511844b5/00602537869770.rgb.jpg/100x100bb.jpg", 
             collectionPrice: 9.88,
             trackPrice: 1.29,
             releaseDate: "2005-01-01T12:00:00Z", 
             trackCount: 14,
             trackNumber: trackID,
             trackTimeMillis: 208643,
             country: "USA",
             currency: "USD",
             primaryGenreName: "Rock",
             collectionArtistName: nil)
    }
}
