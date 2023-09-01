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
           let price = formattedPrice() {
            Link(destination: url, label: {
                Text("\(price)")
            })
            .buttonStyle(BuyButtonStyle())
        }
    }

    private func formattedPrice() -> String? {
        guard let price else {
            return nil
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency

        let priceString = formatter.string(from: NSNumber(value: price))
        return priceString
    }
}

#Preview {
    BuyButton(urlString: "https://www.google.it", price: 9.99, currency: "EUR")
}

