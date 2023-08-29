//
//  FetchState.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Foundation

enum FetchState: Comparable  {
    case initial
    case isLoading
    case loadedAll
    case error(String)
}
