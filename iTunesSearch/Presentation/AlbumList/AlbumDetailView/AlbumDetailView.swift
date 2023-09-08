//
//  AlbumDetailView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct AlbumDetailView: View {

    let album: Album

    @StateObject var songsForAlbumViewModel: SongsForAlbumListViewModel

    init(album: Album) {
        print("init Album detail \(album.collectionID)")
        self.album = album
        self._songsForAlbumViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.collectionID))
    }

    var body: some View {
        VStack {
            AlbumHeaderDetailView(album: album)
            SongsForAlbumListView(songsForAlbumViewModel: songsForAlbumViewModel, 
                                  selectedSong: nil)
        }
        .onAppear() {
            songsForAlbumViewModel.fetch()
        }
    }


}

#Preview {
    AlbumDetailView(album: Album.mock())
}
