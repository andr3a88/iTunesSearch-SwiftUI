//
//  APIService.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

protocol APIServiceType {
    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<AlbumResult, APIError>) -> Void)
    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<SongResult, APIError>) -> Void)
    func fetchMovies(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<MovieResult, APIError>) -> Void)
}

final class APIService {

    // MARK: Fetch data from iTunes Search API

    func fetchAlbums(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<AlbumResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .album, page: page, limit: limit)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }

    func fetchSongs(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<SongResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .song, page: page, limit: limit)
        fetch(type: SongResult.self, url: url, completion: completion)
    }

    func fetchMovies(searchTerm: String, page: Int, limit: Int, completion: @escaping (Result<MovieResult, APIError>) -> Void) {
        let url = createURL(for: searchTerm, type: .movie, page: page, limit: limit)
        fetch(type: MovieResult.self, url: url, completion: completion)
    }

    // MARK: Private

    private func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping (Result<T, APIError>) -> Void) {

        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.urlSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(.decoding(error as? DecodingError)))
                    print("\(error.localizedDescription)")
                }
            }
        }.resume()
    }

    // https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
    // https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
    // https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
    private func createURL(for searchTerm: String, type: EntityType, page: Int?, limit: Int?) -> URL? {
        let baseURL = "https://itunes.apple.com/search"

        var queryItems = [URLQueryItem(name: "term", value: searchTerm),
                          URLQueryItem(name: "entity", value: type.rawValue)
        ]

        if let page, let limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }

        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        return components?.url
    }
}
