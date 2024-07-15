//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Mohammad Blur on 7/15/24.
//

import SwiftUI
import WidgetKit

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: .now, repo: MockData.repoOne)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: .now, repo: MockData.repoTow)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<ContributorEntry>) -> Void) {
        let nextUpdate = Date().addingTimeInterval(43200)
        let entry = ContributorEntry(date: .now, repo: MockData.repoOne)
        let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeLine)
    }
}

struct ContributorEntry: TimelineEntry {
    var date: Date
    var repo: Repository
}

struct ContributorEntryView : View {
    var entry: ContributorEntry
    
    var body: some View {
        VStack(spacing: 20) {
            RepoMediumView(repo: entry.repo)
            
            ContributorMediumView(repo: entry.repo)
            .padding(.vertical)
        }
    }
}


struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            if #available(iOS 17.0, *) {
                ContributorEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ContributorEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Contrybutor")
        .description("Keep track of a repository's contribuors.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    ContributorWidget()
} timeline: {
    ContributorEntry(date: .now, repo: MockData.repoOne)
}

