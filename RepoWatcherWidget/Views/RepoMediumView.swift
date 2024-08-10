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
                Text("\(repo.daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(repo.daysSinceLastActivity > 50 ? Color.pink : Color.green)
                    .contentTransition(.numericText() )
                Text("days ago")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
            }
        }
    }
    

}

//#Preview(as: .systemMedium, widget: {
//    DoubleRepoWidget()
//}, timeline: {
//    DoubleRepoEntry(date: .now, topRepo: MockData.repoOne, bottomRepo:  MockData.repoTow)
//})
//   
//  

fileprivate struct StatLabel: View {
    
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
                .contentTransition(.numericText())
        } icon: {
            Image(systemName: systemImageName)
                .foregroundStyle(.green)
        }
        .fontWeight(.medium)

    }
}
