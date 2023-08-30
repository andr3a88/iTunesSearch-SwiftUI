//
//  SearchAllListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct SearchAllListView: View {

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

                    NavigationLink {
                        SongListView(viewModel: songViewModel)
                    } label: {
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

                    NavigationLink {
                        AlbumListView(viewModel: albumViewModel)
                    } label: {
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

                    NavigationLink {
                        MovieListView(viewModel: movieViewModel)
                    } label: {
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
    }
}

#Preview {
    SearchAllListView(albumViewModel: AlbumListViewModel.mock(),
                      songViewModel: SongListViewModel.mock(),
                      movieViewModel: MovieListViewModel.mock())
}
