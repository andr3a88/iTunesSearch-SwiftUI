//
//  SearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI
import WidgetKit

struct SearchView: View {

    static let suggestions = ["Daft Punk",
                              "Tiesto",
                              "Rammstein",
                              "Batman",
                              "Maneskin"]

    @State private var searchTerm: String = ""
    @State private var selectedEntityType: EntityType = .all
    @State private var clearSearch: Bool = false

    @StateObject private var recentSearchRepository: RecentSearchRepository
    @StateObject private var albumViewModel: AlbumListViewModel
    @StateObject private var songViewModel: SongListViewModel
    @StateObject private var movieViewModel: MovieListViewModel
    
    init(container: DIContainer) {
        _recentSearchRepository = StateObject(wrappedValue: container.recentSearchRepository)
        _albumViewModel = StateObject(wrappedValue: AlbumListViewModel(recentSearchRepository: container.recentSearchRepository))
        _songViewModel = StateObject(wrappedValue: SongListViewModel(recentSearchRepository: container.recentSearchRepository))
        _movieViewModel = StateObject(wrappedValue: MovieListViewModel(recentSearchRepository: container.recentSearchRepository))
    }

    var body: some View {
        VStack {
            Picker("Select the media",
                   selection: $selectedEntityType,
                   content: {
                ForEach(EntityType.allCases) { type in
                    Text(type.title)
                        .tag(type)
                }
            })
            .pickerStyle(.segmented)
            .padding(.horizontal)
            Divider()

            if searchTerm.isEmpty {
                RecentSearchView(searchTerm: $searchTerm,
                                 clearSearch: $clearSearch,
                                 recentSearch: $recentSearchRepository.recentSearch)
                SearchPlaceholderView(searchTerm: $searchTerm, suggestions: Self.suggestions)
                    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            } else {
                switch selectedEntityType {
                case .all:
                    SearchAllListView(albumViewModel: albumViewModel,
                                      songViewModel: songViewModel,
                                      movieViewModel: movieViewModel)
                case .album:
                    AlbumListView(viewModel: albumViewModel)

                case .song:
                    SongListView(viewModel: songViewModel)

                case .movie:
                    MovieListView(viewModel: movieViewModel)
                }
            }
        }
        .searchable(text: $searchTerm)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedEntityType, perform: { newValue in
            updateViewModels(for: searchTerm, type: newValue)
            WidgetCenter.shared.reloadAllTimelines()
        })
        .onChange(of: searchTerm) { newValue in
            updateViewModels(for: newValue, type: selectedEntityType)
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: clearSearch) { newValue in
            recentSearchRepository.clear()
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

    private func updateViewModels(for searchTerm: String, type: EntityType) {
        switch selectedEntityType {
        case .all:
            albumViewModel.searchTerm = searchTerm
            songViewModel.searchTerm = searchTerm
            movieViewModel.searchTerm = searchTerm
        case .album:
            albumViewModel.searchTerm = searchTerm
            songViewModel.searchTerm = ""
            movieViewModel.searchTerm = ""
        case .song:
            albumViewModel.searchTerm = ""
            songViewModel.searchTerm = searchTerm
            movieViewModel.searchTerm = ""
        case .movie:
            albumViewModel.searchTerm = ""
            songViewModel.searchTerm = ""
            movieViewModel.searchTerm = searchTerm
        }
    }
}

#Preview {
    SearchView(container: DIContainer())
}
