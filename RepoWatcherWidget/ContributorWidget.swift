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
        Task {
            let nextUpdate = Date().addingTimeInterval(43200)
            do {
                let repoToShow = RepoURL.repoWatcher
                let entry = ContributorEntry(date: .now, repo: MockData.repoOne)
                
                // get repo
                var repo = try await NetworkManager.shared.getRepo(at: repoToShow)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                //Get Contribution
                let contributors = try await NetworkManager.shared.getContributor(at: repoToShow + "/contributors")
                
                // Filter to just Top 4
                var topFour = Array(contributors.prefix(4))
                
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeLine)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
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

