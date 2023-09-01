//
//  AlbumHeaderDetailView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 31/08/23.
//

import SwiftUI

struct AlbumHeaderDetailView: View {

    let album: Album

    var body: some View {
        HStack(alignment: .bottom) {
            ImageLoadingView(urlImage: album.artworkUrl100, size: 100)

            VStack(alignment: .leading) {
                Text(album.collectionName)
                    .font(.footnote)
                    .foregroundColor(Color(.label))
                Text(album.artistName)
                Text(album.primaryGenreName)
                Text("\(album.trackCount) songs")
                Text("Released \(formattedDate(value: album.releaseDate ?? ""))")
            }
            .font(.caption)
            .foregroundColor(.gray)
            .lineLimit(1)

            Spacer(minLength: 20)

            BuyButton(urlString: album.collectionViewURL,
                      price: album.collectionPrice,
                      currency: album.currency)
        }
        .padding()
        .background(
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.top)
                .shadow(radius: 5)
        )
    }

    private func formattedDate(value: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        guard let date = dateFormatter.date(from: value) else {
            return ""
        }

        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: date)
    }
}

#Preview {
    AlbumHeaderDetailView(album: Album.mock())
}
