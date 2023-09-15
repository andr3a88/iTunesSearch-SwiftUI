//
//  SearchAllListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI



struct SearchAllListView: View {

    enum SeeAll: String {
        case songs
        case albums
        case movies
    }

    @ObservedObject var albumViewModel: AlbumListViewModel
    @ObservedObject var songViewModel: SongListViewModel
    @ObservedObject var movieViewModel: MovieListViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {

                HStack {
                    Text("Songs")
                        .font(.title)

                    Spacer()

                    NavigationLink(value: SeeAll.songs) {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding(.horizontal)
                SongSectionView(songs: songViewModel.songs)

                Divider()
                    .padding(.bottom)

                HStack {
                    Text("Albums")
                        .font(.title)

                    Spacer()

                    NavigationLink(value: SeeAll.albums) {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding(.horizontal)
                AlbumSectionView(albums: albumViewModel.albums)

                Divider()
                    .padding(.bottom)

                HStack {
                    Text("Movies")
                        .font(.title)

                    Spacer()

                    NavigationLink(value: SeeAll.movies) {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .padding(.horizontal)
                MovieSectionView(movies: movieViewModel.movies)

                Spacer()
            }
        }
        .navigationDestination(for: SeeAll.self) { section in
            switch section {
            case .songs:
                SongListView(viewModel: songViewModel)
            case .albums:
                AlbumListView(viewModel: albumViewModel)
            case .movies:
                MovieListView(viewModel: movieViewModel)
            }
        }
    }
}

#Preview {
    SearchAllListView(albumViewModel: AlbumListViewModel.mock(),
                      songViewModel: SongListViewModel.mock(),
                      movieViewModel: MovieListViewModel.mock())
}
