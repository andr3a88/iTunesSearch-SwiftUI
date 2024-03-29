//
//  AlbumListViewModelTests.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 05/09/23.
//

import Combine
import XCTest
@testable import iTunesSearch

final class AlbumListViewModelTests: XCTestCase {

    // MARK: Properties

    var sut: AlbumListViewModel!
    var apiService: APIServiceMock!

    private var subscriptions = Set<AnyCancellable>()

    // MARK: Methods

    override func setUpWithError() throws {
        apiService = APIServiceMock()
        sut = AlbumListViewModel(service: apiService)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_load_albums_success() throws {
        // Configure albums
        apiService.albums = Array(0..<4).map { Album.mock(collectionID: $0) }

        var albums = [Album]()
        let expectation = XCTestExpectation(description: "Expect albums")

        // Trigger load albums
        sut.searchTerm = "change search term"

        sut.$albums
            .sink(receiveValue: { result in
                albums = result
            })
            .store(in: &subscriptions)

        // Detect when the view model has finished to load
        sut.$state
            .sink { state in
                if state == .loadedAll {
                    expectation.fulfill()
                }
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(albums.count, 4, "Invalid albums count")
        XCTAssertEqual(albums.first!.collectionID, 0, "The first album has collectionID equal to 0")
    }
}
