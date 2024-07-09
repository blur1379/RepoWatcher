//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Mohammad Blur on 7/7/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RepoEntry {
        RepoEntry(date: Date(), emoji: "😀", repo: Repository.placeHolder)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), emoji: "😀", repo: Repository.placeHolder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RepoEntry] = []

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct RepoEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let repo: Repository
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
                .padding(.bottom)
                HStack {
                    StatLabel(value: 999, systemImageName: "star.fill")
                    StatLabel(value: 888, systemImageName: "tuningfork")
                    StatLabel(value: 555, systemImageName: "exclamationmark.triangle.fill")
                }
                
            }
            
            Spacer()
            
            VStack {
                Text("99")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                
                Text("days ago")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
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
    RepoEntry(date: .now, emoji: "😀", repo: Repository.placeHolder)
    RepoEntry(date: .now, emoji: "🤩", repo: Repository.placeHolder)
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
