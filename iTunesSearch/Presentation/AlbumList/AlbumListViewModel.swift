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

    private let limit: Int = 10
    private var page: Int = 0

    private let service: APIServiceType = APIService()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbum(searchTerm: term)
            }.store(in: &subscriptions)
    }

    private func clear() {
        state = .initial
        albums = []
        page = 0
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

        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            guard let self else { return }
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

extension AlbumListViewModel {

    static func mock() -> AlbumListViewModel {
        let viewModel = AlbumListViewModel()
        viewModel.albums = [Album.mock()]
        return viewModel
    }
}

