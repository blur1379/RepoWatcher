//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Mohammad Blur on 7/7/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct RepoWatcherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    
                    Text("Swift news")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    
                }
                

                
            }
            VStack {
                Text("99")
            }
        }
    }
}

struct RepoWatcherWidget: Widget {
let kind: String = "RepoWatcherWidget"

var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
        if #available(iOS 17.0, *) {
            RepoWatcherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        } else {
            RepoWatcherWidgetEntryView(entry: entry)
                .padding()
                .background()
        }
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
}
}

#Preview(as: .systemMedium) {
    RepoWatcherWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}

fileprivate struct StatLabel: View {
    
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundStyle(.green)
        }
        .fontWeight(.medium)

    }
}
