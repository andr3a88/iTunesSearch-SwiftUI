//
//  SongsForAlbumListViewModel.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import Foundation

final class SongsForAlbumListViewModel: ObservableObject {

    @Published var songs: [Song] = []
    @Published var state: FetchState = .initial

    private let albumID: Int
    private let service: APIServiceType

    init(service: APIServiceType = APIService(),
         albumID: Int) {
        self.service = service
        self.albumID = albumID
    }

    func fetch() {
        fetchSongs(for: albumID)
    }

    private func fetchSongs(for albumID: Int) {
        state = .isLoading

        service.fetchSongs(for: albumID) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    // Itunes API returns as first element `results`, return the Album object (we need to remove it)
                    self.songs = Array(result.results.dropFirst())
                    self.state = .initial
                    print("fetched \(result.resultCount) songs form albumID: \(self.albumID)")
                case .failure(let error):
                    self.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension SongsForAlbumListViewModel {

    static func mock() -> SongsForAlbumListViewModel {
        let viewModel = SongsForAlbumListViewModel(albumID: 213038820)
        viewModel.songs = [Song.mock(trackID: 1), Song.mock(trackID: 2), Song.mock(trackID: 3)]
        return viewModel
    }
}
