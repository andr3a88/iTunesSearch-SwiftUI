//
//  MovieListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct MovieListView: View {

    @ObservedObject var viewModel: MovieListViewModel

    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailView(movie: movie)
                } label: {
                    MovieRowView(movie: movie)
                }
                .buttonStyle(.plain)
            }
            switch viewModel.state {
            case .initial:
                Color.clear
                    .onAppear {
                        viewModel.loadMore()
                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                EmptyView()
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
            }
        }
        .listStyle(.grouped)
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel.mock())
}
