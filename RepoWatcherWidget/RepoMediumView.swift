//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Mohammad Blur on 7/11/24.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    var daysSinceLastActivity: Int {
        calculateDaySinceLastActivity(from: repo.pushedAt)
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    if let imageData = UIImage(data: repo.avatarData) {
                        Image(uiImage: imageData)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.gray)
                            .frame(width: 50, height: 50)
                    }
                  
                    
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    
                }
                .padding(.bottom)
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
                
            }
            
            Spacer()
            
            VStack {
                Text("\(daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daysSinceLastActivity > 50 ? Color.pink : Color.green)
                
                Text("days ago")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
            }
        }
    }
    
    func calculateDaySinceLastActivity(from dateString: String) -> Int {
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        let daysSinceLastActivity = Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
        return daysSinceLastActivity
    }
}

struct RepoMediumView_Preview: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: Repository.placeHolder)
            .containerBackground(.fill.tertiary, for: .widget)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
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
