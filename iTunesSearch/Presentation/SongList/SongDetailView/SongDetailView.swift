//
//  SongDetailView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 31/08/23.
//

import SwiftUI

struct SongDetailView: View {

    let song: Song

    @StateObject var songsForAlbumViewModel: SongsForAlbumListViewModel
    @StateObject var albumForSongViewModel = AlbumForSongViewModel()

    init(song: Song) {
        print("init Song detail \(song.trackID)")
        self.song = song
        self._songsForAlbumViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: song.collectionID))
    }

    var body: some View {
        VStack {
            if let album = albumForSongViewModel.album {
                AlbumHeaderDetailView(album: album)
                    .navigationTitle(Text("\(album.collectionName)"))
                    .navigationBarTitleDisplayMode(.inline)

            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            SongsForAlbumListView(songsForAlbumViewModel: songsForAlbumViewModel, 
                                  selectedSong: song)
        }
        .onAppear() {
            songsForAlbumViewModel.fetch()
            albumForSongViewModel.fetch(song: song)
        }

    }
}

#Preview {
    SongDetailView(song: Song.mock())
}
