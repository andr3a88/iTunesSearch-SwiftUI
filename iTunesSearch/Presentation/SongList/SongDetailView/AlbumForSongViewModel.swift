//
//  AlbumForSongViewModel.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 31/08/23.
//

import Foundation

final class AlbumForSongViewModel: ObservableObject {

    @Published var album: Album? = nil
    @Published var state: FetchState = .initial

    private let service: APIServiceType = APIService()

    func fetch(song: Song) {
        state = .isLoading
        let albumID = song.collectionID

        service.fetchAlbum(for: albumID) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.album = result.results.first
                    self.state = .initial
                    print("fetched \(result.resultCount) albums for track name \(song.trackName)")
                case .failure(let error):
                    print("AlbumForSongViewModel: \(error)")
                    self.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }

}
