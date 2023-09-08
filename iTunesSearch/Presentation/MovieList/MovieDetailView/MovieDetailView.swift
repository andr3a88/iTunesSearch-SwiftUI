//
//  MovieDetailView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 08/09/23.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    var body: some View {
        MovieRowView(movie: movie)
            .padding()
        ScrollView {

        }
        .navigationTitle("\(movie.trackName)")
        .navigationBarTitleDisplayMode(.inline)

        Spacer()
    }

}

#Preview {
    MovieDetailView(movie: Movie.mock(trackID: 1))
}
