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
        apiService.albums = [Album.mock(collectionID: 1),
                             Album.mock(collectionID: 2),
                             Album.mock(collectionID: 3),
                             Album.mock(collectionID: 4)]

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

        XCTAssertEqual(albums.count, 4, "The albums count should be 3")
        XCTAssertEqual(albums.first!.collectionID, 1, "The first album has collectionID equal to 1")
    }
}
