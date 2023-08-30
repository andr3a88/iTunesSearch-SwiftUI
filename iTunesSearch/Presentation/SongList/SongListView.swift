//
//  SongListView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct SongListView: View {

    @ObservedObject var viewModel: SongListViewModel

    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                SongRowView(song: song)
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
    SongListView(viewModel: SongListViewModel.mock())
}
