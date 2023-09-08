//
//  SearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct SearchView: View {

    static let suggestions = ["Daft Punk",
                              "Tiesto",
                              "Rammstein",
                              "Batman",
                              "Maneskin"]

    @State private var searchTerm: String = ""
    @State private var selectedEntityType: EntityType = .all

    @StateObject private var albumViewModel = AlbumListViewModel()
    @StateObject private var songViewModel = SongListViewModel()
    @StateObject private var movieViewModel = MovieListViewModel()

    var body: some View {
        NavigationStack {
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
        }
        .onChange(of: selectedEntityType, perform: { newValue in
            updateViewModels(for: searchTerm, type: newValue)
        })
        .onChange(of: searchTerm) { newValue in
            updateViewModels(for: newValue, type: selectedEntityType)
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
    SearchView()
}
