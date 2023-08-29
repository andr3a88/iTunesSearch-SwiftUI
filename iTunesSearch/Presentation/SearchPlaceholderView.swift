//
//  SearchPlaceholderView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

struct SearchPlaceholderView: View {

    @Binding var searchTerm: String

    let suggestions: [String]

    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button(action: {
                    searchTerm = text
                }, label: {
                    Text(text)
                })
            }
        }
    }
}

#Preview {
    SearchPlaceholderView(searchTerm: .constant(""), suggestions: ["Avicii", "Marting Garrix", "Alesso"]
)
}
