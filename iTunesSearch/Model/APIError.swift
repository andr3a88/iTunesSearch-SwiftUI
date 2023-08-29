//
//  APIError.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown

    var description: String {
        switch self {
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession error: \(error.debugDescription)"
        case .badResponse(let code):
            return "badResponse code \(code)"
        case .decoding(let decodingError):
            return "decodingError: \(String(describing: decodingError))"
        case .unknown:
            return "unknown error"
        }
    }

    var localizedDescription: String {
        switch self {
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession error: \(error.debugDescription)"
        case .badResponse(let code):
            return "badResponse code \(code)"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "something wrong"
        case .unknown:
            return "unknown error"
        }
    }
}
