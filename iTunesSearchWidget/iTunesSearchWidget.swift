//
//  iTunesSearchWidget.swift
//  iTunesSearchWidget
//
//  Created by Andrea Stevanato on 22/09/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), suggestions: self.getRecentSearch())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), suggestions: self.getRecentSearch())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, suggestions: self.getRecentSearch())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getRecentSearch() -> [String] {
        let recentSearchRepository = RecentSearchRepository()
        let recentSearch = recentSearchRepository.fetch()
        return recentSearch.isEmpty ? ["No recent search"] : recentSearch
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let suggestions: [String]
}

struct iTunesSearchWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Recent Search:")
                .font(.headline)
            Spacer()
            ForEach(entry.suggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .font(.footnote)
            }
            Spacer()
        }
    }
}

struct iTunesSearchWidget: Widget {
    let kind: String = "iTunesSearchWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                iTunesSearchWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                iTunesSearchWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("iTunes Search")
        .description("Recent search")
    }
}

#Preview(as: .systemMedium) {
    iTunesSearchWidget()
} timeline: {
    SimpleEntry(date: .now, suggestions: Array(0..<5).map { "Search\($0)"})
}
