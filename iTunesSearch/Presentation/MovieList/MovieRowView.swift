//
//  MovieRowView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct MovieRowView: View {

    let movie: Movie

    var body: some View {
        HStack {
            ImageLoadingView(urlImage: movie.artworkUrl100, size: 100)

            VStack(alignment: .leading) {
                Text(movie.trackName)
                Text(movie.primaryGenreName)
                    .foregroundColor(.gray)
                Text(movie.releaseDate ?? "")
                    .foregroundColor(.gray)
            }
            .font(.caption)

            Spacer(minLength: 20)

            BuyButton(urlString: movie.trackViewURL,
                      price: movie.trackPrice,
                      currency: movie.currency)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie.mock())
}
