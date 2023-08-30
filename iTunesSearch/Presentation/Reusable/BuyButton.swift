//
//  BuyButton.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 30/08/23.
//

import SwiftUI

struct BuyButton: View {

    let urlString: String
    let price: Double?
    let currency: String


    var body: some View {
        if let url = URL(string: urlString),
           let price = price {
            Link(destination: url, label: {
                Text(" \(Int(price)) \(currency)")
            })
            .buttonStyle(BuyButtonStyle())
        }
    }
}

#Preview {
    BuyButton(urlString: "https://www.google.it", price: 9.99, currency: "€")
}

