//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.quarternote.3")
                }
            SongSearchListView()
                .tabItem {
                    Label("Song", systemImage: "music.note")
                }
            MovieSearchListView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
        }
    }
}

#Preview {
    ContentView()
}
