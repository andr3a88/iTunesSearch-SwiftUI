//
//  AlbumListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct AlbumListView: View {

    @StateObject var viewModel = AlbumListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.albums) { album in
                Text(album.collectionName)
            }
            .listStyle(.grouped)
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Album")
        }
    }
}

#Preview {
    AlbumListView()
}
