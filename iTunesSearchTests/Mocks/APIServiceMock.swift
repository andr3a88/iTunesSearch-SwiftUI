//
//  APIServiceMock.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 05/09/23.
//

import Foundation
@testable import iTunesSearch

final class APIServiceMock: APIServiceType {

    // MARK: Properties

    var fetchAlbumsForSearchTermCalled: Bool = false
    var fetchAlbumCalled: Bool = false
    var fetchSongsSearchTermCalled: Bool = false
    var fetchSongsForAlbumCalled: Bool = false
    var fetchMovies: Bool = false

    var albums: [Album] = []
    var songs: [Song] = []
    var movies: [Movie] = []

    // MARK: Methods

    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<iTunesSearch.AlbumResult, iTunesSearch.APIError>) -> Void) {
        fetchAlbumsForSearchTermCalled = true

        let result = AlbumResult(resultCount: albums.count, results: albums)
        completion(.success(result))
    }
    
    func fetchAlbum(for albumID: Int, completion: @escaping (Result<iTunesSearch.AlbumResult, iTunesSearch.APIError>) -> Void) {
        fetchAlbumCalled = true

        let result = AlbumResult(resultCount: albums.count, results: albums)
        completion(.success(result))
    }
    
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<iTunesSearch.SongResult, iTunesSearch.APIError>) -> Void) {
        fetchSongsSearchTermCalled = true

        let result = SongResult(resultCount: songs.count, results: songs)
        completion(.success(result))
    }
    
    func fetchSongs(for albumID: Int, completion: @escaping (Result<iTunesSearch.SongResult, iTunesSearch.APIError>) -> Void) {
        fetchSongsForAlbumCalled = true

        let result = SongResult(resultCount: songs.count, results: songs)
        completion(.success(result))
    }
    
    func fetchMovies(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<iTunesSearch.MovieResult, iTunesSearch.APIError>) -> Void) {
        fetchMovies = true

        let result = MovieResult(resultCount: movies.count, results: movies)
        completion(.success(result))
    }

}
