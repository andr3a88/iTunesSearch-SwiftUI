//
//  APIServiceTests.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 31/08/23.
//

import XCTest
@testable import iTunesSearch

final class APIServiceTests: XCTestCase {

    // MARK: Properties

    var sut: APIService!

    // MARK: Methods

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockUrlSession = URLSession.init(configuration: configuration)

        sut = APIService(session: mockUrlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_successful_response() throws {
        let data = Data.loadJSON(filename: "songsResult")

        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw APIError.badURL
            }

            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let expectation = expectation(description: "API call")

        sut.fetchSongs(for: 1) { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result.resultCount, 5, "Incorrect resultCount")
                XCTAssertEqual(result.results.count, 5, "Incorrect results")

                let song = try?  XCTUnwrap(result.results.first) as Song
                XCTAssertEqual(song?.trackName, "Jack Johnson", "Incorrect trackName")

            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
