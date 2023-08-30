//
//  MovieSearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct MovieSearchView: View {

    @StateObject private var viewModel = MovieListViewModel()

    private let suggestions = ["Batman", "Avengers", "fast and furious"]

    var body: some View {
        NavigationView {
            Group {
                if viewModel.searchTerm.isEmpty {
                    SearchPlaceholderView(searchTerm: $viewModel.searchTerm,
                                          suggestions: suggestions)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

#Preview {
    MovieSearchView()
}
