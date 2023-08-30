//
//  SongListViewModel.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Combine
import Foundation

final class SongListViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var songs: [Song] = []
    @Published var state: FetchState = .initial

    private let limit: Int = 10
    private var page: Int = 0

    private let service = APIService()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(searchTerm: term)
            }.store(in: &subscriptions)
    }

    private func clear() {
        state = .initial
        songs = []
        page = 0
    }

    func loadMore() {
        fetchSongs(searchTerm: searchTerm)
    }

    private func fetchSongs(searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .initial else {
            return
        }

        state = .isLoading

        service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for song in result.results {
                        self.songs.append(song)
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

extension SongListViewModel {
    
    static func mock() -> SongListViewModel {
        let viewModel = SongListViewModel()
        viewModel.songs = [Song.mock()]
        return viewModel
    }
}
