//
//  SongSearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct SongSearchView: View {

    @StateObject private var viewModel = SongListViewModel()

    private let suggestions = ["Smells Like Teen Spirit", "Billie Jean", "Alive"]

    var body: some View {
        Group {
            if viewModel.searchTerm.isEmpty {
                SearchPlaceholderView(searchTerm: $viewModel.searchTerm,
                                      suggestions: suggestions)
            } else {
                SongListView(viewModel: viewModel)
            }
        }
        .searchable(text: $viewModel.searchTerm)
        .navigationTitle("Search Song")
    }
}

#Preview {
    SongSearchView()
}
