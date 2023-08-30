//
//  SearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct SearchView: View {

    @State private var searchTerm: String = ""
    @State private var selectedEntityType: EntityType = .all

    @StateObject private var albumViewModel = AlbumListViewModel()
    @StateObject private var songViewModel = SongListViewModel()
    @StateObject private var movieViewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
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
                    SearchPlaceholderView(searchTerm: $searchTerm, suggestions: ["Daft Punk", "Batman" ])
                        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                } else {
                    switch selectedEntityType {
                    case .all:
                        SearchAllListView(albumViewModel: albumViewModel,
                                          songViewModel: songViewModel,
                                          movieViewModel: movieViewModel)
                        .onAppear {
                            albumViewModel.searchTerm = searchTerm
                            songViewModel.searchTerm = searchTerm
                            movieViewModel.searchTerm = searchTerm
                        }
                    case .album:
                        AlbumListView(viewModel: albumViewModel)
                            .onAppear {
                                albumViewModel.searchTerm = searchTerm
                            }
                    case .song:
                        SongListView(viewModel: songViewModel)
                            .onAppear {
                                albumViewModel.searchTerm = searchTerm
                            }
                    case .movie:
                        MovieListView(viewModel: movieViewModel)
                            .onAppear {
                                albumViewModel.searchTerm = searchTerm
                            }
                    }
                }
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { oldValue, newValue in
            switch selectedEntityType {
            case .all:
                albumViewModel.searchTerm = newValue
                songViewModel.searchTerm = newValue
                movieViewModel.searchTerm = newValue
            case .album:
                albumViewModel.searchTerm = newValue
            case .song:
                songViewModel.searchTerm = newValue
            case .movie:
                movieViewModel.searchTerm = newValue
            }
        }
    }
}

#Preview {
    SearchView()
}
