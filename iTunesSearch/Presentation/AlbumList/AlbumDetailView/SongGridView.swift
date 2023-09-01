//
//  SongGridView.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 31/08/23.
//

import SwiftUI

struct SongGridView: View {

    let songs: [Song]
    let selectedSong: Song?

    var body: some View {
        Grid(horizontalSpacing: 20) {
            ForEach(songs) { song in
                GridRow {
                    Text("\(song.trackNumber)")
                        .font(.footnote)
                        .gridColumnAlignment(.trailing)

                    Text(song.trackName)
                        .gridColumnAlignment(.leading)

                    Spacer()

                    Text(formattedDuration(time: song.trackTimeMillis ?? 0))
                        .font(.footnote)

                    BuyButton(urlString: song.previewURL,
                              price: song.trackPrice,
                              currency: song.currency)
                }
                .foregroundColor(song == selectedSong ? .accentColor : Color(.label))
                .id(song.trackNumber)
                Divider()
            }
        }
        .padding([.vertical, .trailing])
    }

    private func formattedDuration(time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]

        let interval = TimeInterval(time / 1000)
        return formatter.string(from: interval) ?? ""
    }
}

#Preview {
    SongGridView(songs: [Song.mock(trackID: 1), Song.mock(trackID: 2), Song.mock(trackID: 3)],
                 selectedSong: Song.mock(trackID: 2))
}
