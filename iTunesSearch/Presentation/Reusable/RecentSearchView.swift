//
//  RecentSearchView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 26/09/23.
//

import SwiftUI

struct RecentSearchView: View {
    
    @Binding var searchTerm: String
    @Binding var clearSearch: Bool
    @Binding var recentSearch: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            if !recentSearch.isEmpty {
                Text("Recent Search")
                    .font(.title)
                ForEach(recentSearch, id: \.self) { text in
                    Button(action: {
                        searchTerm = text
                    }, label: {
                        Text(text)
                    })
                }
                Button("Clear", role: .destructive) {
                    clearSearch = true
                }
                .buttonStyle(.bordered)
                .font(.footnote)
            }
        }
    }
}

#Preview {
    RecentSearchView(searchTerm: .constant(""),
                     clearSearch: .constant(false),
                     recentSearch: .constant(["search 1", "search 2"])
    )
}
