//
//  EntityType.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie

    var id: String {
        self.rawValue
    }

    var title: String {
        switch self {
        case .all:
            return "All"
        case .album:
            return "Albums"
        case .song:
            return "Songs"
        case .movie:
            return "Movies"
        }
    }
}
