//
//  MockURLProtocol.swift
//  iTunesSearchTests
//
//  Created by Andrea Stevanato on 05/09/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask
}

extension URLSession : URLSessionProtocol{}
extension URLSessionDataTask : URLSessionDataTaskProtocol{}

final class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {
            // Capture the tuple of response and data.
            let (response, data) = try handler(request)

            // Send received response to the client.
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                // Send received data to the client.
                client?.urlProtocol(self, didLoad: data)
            }

            // Notify request has been finished.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // Notify received error.
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {
    }
}
