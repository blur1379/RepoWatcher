//
//  SingleRepoWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Mohammad Blur on 7/15/24.
//

import SwiftUI
import WidgetKit

struct SingleRepoProvider: AppIntentTimelineProvider {
    func snapshot(for configuration: SelectSingleRepo, in context: Context) async -> SingleRepoEntry {
        let entry = SingleRepoEntry(date: .now, repo: MockData.repoOne)
        return entry
    }
    
    func timeline(for configuration: SelectSingleRepo, in context: Context) async -> Timeline<SingleRepoEntry> {
        
        let nextUpdate = Date().addingTimeInterval(43200)
        do {
            let repoToShow = RepoURL.prefix + configuration.repo!
            
            // get repo
            var repo = try await NetworkManager.shared.getRepo(at: repoToShow)
            let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
            repo.avatarData = avatarImageData ?? Data()
            
            if context.family == .systemLarge {
                //Get Contribution
                let contributors = try await NetworkManager.shared.getContributor(at: repoToShow + "/contributors")
                
                // Filter to just Top 4
                var topFour = Array(contributors.prefix(4))
                
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
            }
            
            let entry = SingleRepoEntry(date: .now, repo: repo)
            let timeLine = Timeline(entries: [entry], policy: .after(nextUpdate))
            return timeLine
        } catch {
            print("❌ Error - \(error.localizedDescription)")
        }
        
    }
    
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
 
  
}

struct SingleRepoEntry: TimelineEntry {
    var date: Date
    var repo: Repository
}

struct SingleRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry
    
    var body: some View {
        VStack(spacing: 20) {
            
            switch family {
            case .systemMedium:
                RepoMediumView(repo: entry.repo)
            case .systemLarge:
                RepoMediumView(repo: entry.repo)
                ContributorMediumView(repo: entry.repo)
                .padding(.vertical)
            default:
                EmptyView()
            }
        }
    }
}


struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"
    
    var body: some WidgetConfiguration {
        
        AppIntentConfiguration(kind: kind, intent: SelectSingleRepo.self, provider: SingleRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                SingleRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SingleRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Single Repo")
        .description("Track a single repository's .")
        .supportedFamilies([.systemMedium,.systemLarge])
    }
}

#Preview(as: .systemMedium) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
}

