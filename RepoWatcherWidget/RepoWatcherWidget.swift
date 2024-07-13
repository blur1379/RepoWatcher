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
        RepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTow)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepoEntry) -> ()) {
        let entry = RepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTow)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                var repo = try await NetworkManager.shared.getRepo(at: RepoURL.repoWatcher)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                let entry = RepoEntry(date: .now, repo: repo, bottomRepo: nil )
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct RepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let bottomRepo: Repository?
}

struct RepoWatcherWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                RepoMediumView(repo: MockData.repoTow)
            }
          
        case .systemExtraLarge, .systemSmall, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
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
    .supportedFamilies([.systemLarge, .systemMedium])
}
}

#Preview(as: .systemLarge) {
    RepoWatcherWidget()
} timeline: {
    RepoEntry(date: .now, repo: MockData.repoOne,bottomRepo: MockData.repoTow)
}
