//
//  MovieSectionView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct MovieSectionView: View {

    let movies: [Movie]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 0) {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        VStack(alignment: .leading) {
                            ImageLoadingView(urlImage: movie.artworkUrl100, size: 100)
                            Text(movie.trackName)
                            Text(movie.primaryGenreName)
                                .foregroundColor(.gray)
                        }
                        .lineLimit(2)
                        .frame(width: 100)
                        .font(.caption)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieSectionView(movies: [Movie.mock()])
}
