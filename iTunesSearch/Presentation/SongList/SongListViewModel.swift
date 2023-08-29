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
                self?.songs = []
                self?.fetchSongs(searchTerm: term)
            }.store(in: &subscriptions)
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
