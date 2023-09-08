//
//  SongListViewModelTests.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 06/09/23.
//

import Combine
import XCTest
@testable import iTunesSearch

final class SongListViewModelTests: XCTestCase {

    // MARK: Properties

    var sut: SongListViewModel!
    var apiService: APIServiceMock!

    private var subscriptions = Set<AnyCancellable>()

    // MARK: Methods

    override func setUpWithError() throws {
        apiService = APIServiceMock()
        sut = SongListViewModel(service: apiService)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_load_songs_success() throws {
        // Configure songs
        apiService.songs = Array(0..<3).map { Song.mock(trackID: $0) }

        var songs = [Song]()
        let expectation = XCTestExpectation(description: "Expect albums")

        // Trigger load songs
        sut.searchTerm = "change search term"

        sut.$songs
            .sink(receiveValue: { result in
                songs = result
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

        XCTAssertEqual(songs.count, 3, "Invalid songs count")
        XCTAssertEqual(songs.first!.trackID, 0, "The first song has trackID equal to 1")
    }
}
