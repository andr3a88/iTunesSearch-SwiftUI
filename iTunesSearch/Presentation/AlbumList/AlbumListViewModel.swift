//
//  AlbumListViewModel.swift
//  iTunes-SwiftUI
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Combine
import Foundation

// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5

final class AlbumListViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var albums: [Album] = []

    let limit: Int = 20

    var subscriptions = Set<AnyCancellable>()

    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.fetchAlbum(searchTerm: term)
        }.store(in: &subscriptions)
    }

    func fetchAlbum(searchTerm: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=10") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        self.albums = result.results
                    }
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }.resume()
    }

}
