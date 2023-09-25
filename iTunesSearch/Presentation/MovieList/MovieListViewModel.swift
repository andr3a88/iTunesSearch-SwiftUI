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

    private let limit: Int = 10
    private var page: Int = 0

    private let service: APIServiceType
    private let recentSearchRepository: RecentSearchRepositoryType
    
    private var subscriptions = Set<AnyCancellable>()

    init(service: APIServiceType = APIService(),
         recentSearchRepository: RecentSearchRepositoryType = RecentSearchRepository()) {
        self.service = service
        self.recentSearchRepository = recentSearchRepository

        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchMovies(searchTerm: term)
                self?.recentSearchRepository.store(searchTerm: term)
            }.store(in: &subscriptions)
    }

    private func clear() {
        state = .initial
        movies = []
        page = 0
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

        service.fetchMovies(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            guard let self else { return }
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

extension MovieListViewModel {

    static func mock() -> MovieListViewModel {
        let viewModel = MovieListViewModel()
        viewModel.movies = [Movie.mock()]
        return viewModel
    }
}
