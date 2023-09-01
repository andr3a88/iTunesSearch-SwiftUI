//
//  SongsForAlbumListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 31/08/23.
//

import SwiftUI

struct SongsForAlbumListView: View {

    @ObservedObject var songsForAlbumViewModel: SongsForAlbumListViewModel

    let selectedSong: Song?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if songsForAlbumViewModel.state == .isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if !songsForAlbumViewModel.songs.isEmpty {
                    SongGridView(songs: songsForAlbumViewModel.songs,
                                 selectedSong: selectedSong)
                    .onAppear {
                        print("scroll in list with \(songsForAlbumViewModel.songs.count)")
                        proxy.scrollTo(selectedSong?.trackNumber, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    SongsForAlbumListView(songsForAlbumViewModel: SongsForAlbumListViewModel.mock(),
                          selectedSong: nil)
}
