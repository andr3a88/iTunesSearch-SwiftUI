//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 29/08/23.
//

import XCTest
@testable import iTunesSearch

final class iTunesSearchTests {}

extension Data {

    static func loadJSON(filename fileName: String) -> Data? {
        if let url = Bundle(for: iTunesSearchTests.self).url(forResource: fileName, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                return nil
            }
        }
        return nil
    }
}
