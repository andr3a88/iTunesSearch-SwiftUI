//
//  MovieListViewModel.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import Combine
import Foundation

final class MovieListViewModel: ObservableObject {

    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = []
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
                self?.movies = []
                self?.fetchMovies(searchTerm: term)
            }.store(in: &subscriptions)
    }

    
    func loadMore() {
        fetchMovies(searchTerm: searchTerm)
    }

    private func fetchMovies(searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .initial else {
            return
        }

        state = .isLoading

        service.fetchMovies(searchTerm: searchTerm, page: page, limit: limit) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for movie in result.results {
                        self.movies.append(movie)
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
