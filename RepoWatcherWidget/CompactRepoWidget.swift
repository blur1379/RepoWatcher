//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Mohammad Blur on 7/7/24.
//

import WidgetKit
import SwiftUI

struct CompactRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompactRepoEntry {
        CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTow)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompactRepoEntry) -> ()) {
        let entry = CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTow)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                var repo = try await NetworkManager.shared.getRepo(at: RepoURL.repoWatcher)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                // using context family for specified code
                var bottomRepo: Repository?
                if context.family == .systemLarge {
                    bottomRepo = try await NetworkManager.shared.getRepo(at: RepoURL.repoWatcher)
                    let avatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo!.owner.avatarUrl)
                    bottomRepo?.avatarData = avatarImageData ?? Data()
                }
                
                let entry = CompactRepoEntry(date: .now, repo: repo, bottomRepo: bottomRepo )
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

struct CompactRepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let bottomRepo: Repository?
}

struct CompactRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: CompactRepoProvider.Entry
    
    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                if let bottomRepo = entry.bottomRepo {
                    RepoMediumView(repo: bottomRepo)
                }
            }
          
        case .systemExtraLarge, .systemSmall, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
        @unknown default:
            EmptyView()
        }
       
    }
}

struct CompactRepoWidget: Widget {
let kind: String = "CompactRepoWidget"

var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: CompactRepoProvider()) { entry in
        if #available(iOS 17.0, *) {
            CompactRepoEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        } else {
            CompactRepoEntryView(entry: entry)
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
    CompactRepoWidget()
} timeline: {
    CompactRepoEntry(date: .now, repo: MockData.repoOne,bottomRepo: MockData.repoTow)
}
