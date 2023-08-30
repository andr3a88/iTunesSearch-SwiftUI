//
//  ImageLoadingView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct ImageLoadingView: View {

    let urlImage: String
    let size: CGFloat

    var body: some View {

        AsyncImage(url: URL(string: urlImage)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size)
            case .success(let image):
                image
                    .border(Color(white: 0.8))
            case .failure(_):
                Color.gray
                    .frame(width: size)
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: size)
    }
}
