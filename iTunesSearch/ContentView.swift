//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct ContentView: View {
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                SearchView(container: container)
                    .navigationDestination(for: Song.self) { song in
                        SongDetailView(song: song)
                    }
                    .navigationDestination(for: Album.self) { album in
                        AlbumDetailView(album: album)
                    }
                    .navigationDestination(for: Movie.self) { movie in
                        MovieDetailView(movie: movie)
                    }
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            NavigationStack {
                AlbumSearchView()
                    .navigationDestination(for: Album.self) { album in
                        AlbumDetailView(album: album)
                    }
            }
            .tabItem {
                Label("Albums", systemImage: "music.quarternote.3")
            }
            NavigationStack {
                SongSearchView()
                    .navigationDestination(for: Song.self) { song in
                        SongDetailView(song: song)
                    }
            }
            .tabItem {
                Label("Songs", systemImage: "music.note")
            }
            NavigationStack {
                MovieSearchView()
                    .navigationDestination(for: Movie.self) { movie in
                        MovieDetailView(movie: movie)
                    }
            }
            .tabItem {
                Label("Movies", systemImage: "film")
            }
        }
    }
}

#Preview {
    ContentView(container: DIContainer())
}
