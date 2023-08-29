//
//  AlbumListViewModel.swift
//  iTunes-SwiftUI
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Combine
import Foundation

final class AlbumListViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var albums: [Album] = []
    @Published var state: FetchState = .initial

    let limit: Int = 10
    var page: Int = 0

    let service = APIService()

    var subscriptions = Set<AnyCancellable>()

    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .initial
                self?.albums = []
                self?.fetchAlbum(searchTerm: term)
            }.store(in: &subscriptions)
    }

    func loadMore() {
        fetchAlbum(searchTerm: searchTerm)
    }

    private func fetchAlbum(searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .initial else {
            return
        }

        state = .isLoading

        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for album in result.results {
                        self.albums.append(album)
                    }
                    self.page += 1
                    self.state = result.results.count == self.limit ? .initial : .loadedAll

                case .failure(let error):
                    self.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
