//
//  SongRowView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct SongRowView: View {

    let song: Song

    var body: some View {
        HStack {
            ImageLoadingView(urlImage: song.artworkUrl60, size: 60)
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName + " - " + song.collectionName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)

            Spacer(minLength: 20)
            
            BuyButton(urlString: song.trackViewURL,
                      price: song.trackPrice,
                      currency: song.currency)
        }
    }
}

#Preview {
    SongRowView(song: Song.mock())
}
