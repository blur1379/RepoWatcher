//
//  ContributorMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Mohammad Blur on 7/15/24.
//

import SwiftUI
import WidgetKit

struct ContributorMediumView: View {
    let repo: Repository
    
    var body: some View {
        VStack {
            HStack {
                Text("Top Contributors")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.secondary)
                Spacer()
            }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2),alignment: .leading, spacing: 20) {
                ForEach(0..<4) { i in
                    HStack {
                        Group {
                            if let image = UIImage(data: repo.avatarData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .frame(width: 22, height: 22)
                        .frame(width: 44, height: 44)
                        .background(.secondary.opacity(0.2))
                        .clipShape(Circle())
                        
                        VStack (alignment: .leading) {
                            Text("Sean Allen")
                                .font(.caption)
                                .minimumScaleFactor(0.7)
                            Text("42")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct ContributorMediumView_Preview: PreviewProvider {
    static var previews: some View {
        ContributorMediumView(repo: MockData.repoOne )
            .containerBackground(.fill.tertiary, for: .widget)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
