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
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.quarternote.3")
                }
            SongSearchView()
                .tabItem {
                    Label("Songs", systemImage: "music.note")
                }
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
        }
    }
}

#Preview {
    ContentView()
}
