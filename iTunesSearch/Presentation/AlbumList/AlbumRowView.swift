//
//  AlbumRowView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct AlbumRowView: View {

    let album: Album

    var body: some View {
        HStack {
            ImageLoadingView(urlImage: album.artworkUrl100, size: 100)

            VStack(alignment: .leading) {
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)

            Spacer(minLength: 20)

            BuyButton(urlString: album.collectionViewURL,
                      price: album.collectionPrice,
                      currency: album.currency)
        }
    }
}

#Preview {
    AlbumRowView(album: Album.mock())
}
