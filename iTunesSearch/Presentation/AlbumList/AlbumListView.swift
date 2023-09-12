//
//  AlbumListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct AlbumListView: View {

    @ObservedObject var viewModel: AlbumListViewModel

    var body: some View {
        List {
            ForEach(viewModel.albums) { album in
                NavigationLink(value: album) {
                    AlbumRowView(album: album)
                }
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
        .navigationDestination(for: Album.self) { album in
            AlbumDetailView(album: album)
        }
    }
}


#Preview {
        AlbumListView(viewModel: AlbumListViewModel.mock())
}
