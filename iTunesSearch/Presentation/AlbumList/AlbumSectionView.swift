//
//  AlbumSectionView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct AlbumSectionView: View {

    let albums: [Album]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top) {
                ForEach(albums) { album in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            AlbumDetailView(album: album)
                        } label: {
                            VStack {
                                ImageLoadingView(urlImage: album.artworkUrl100, size: 100)
                                Text(album.collectionName)
                                Text(album.artistName)
                                    .foregroundColor(.gray)
                            }
                            .lineLimit(2)
                            .frame(width: 100)
                            .font(.caption)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AlbumSectionView(albums: [Album.mock()])
}
