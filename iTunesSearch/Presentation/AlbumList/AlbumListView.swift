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
                AlbumRowView(album: album)
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
                Color.gray
            case .error(let message):
                Text(message)
            }
        }
        .listStyle(.grouped)
    }
}


#Preview {
    AlbumListView(viewModel: AlbumListViewModel())
}
