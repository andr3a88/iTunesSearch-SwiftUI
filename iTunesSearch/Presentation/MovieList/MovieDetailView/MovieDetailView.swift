//
//  MovieDetailView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 08/09/23.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie

    init(movie: Movie) {
        print("init Movie detail \(movie.trackID)")
        self.movie = movie
    }

    var body: some View {
        MovieRowView(movie: movie)
            .padding()
        ScrollView {
            Text("Movie detail view")
        }
        .navigationTitle("\(movie.trackName)")
        .navigationBarTitleDisplayMode(.inline)

        Spacer()
    }

}

#Preview {
    MovieDetailView(movie: Movie.mock(trackID: 1))
}
