//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Mohammad Blur on 7/13/24.
//

import Foundation

struct MockData {
    
    static let repoOne = Repository(
        name: "Repository One",
        owner: Owner(
            avatarUrl: ""
        ),
        hasIssues: true,
        forks: 65,
        watchers: 123,
        openIssues: 55,
        pushedAt: "2022-08-09T18:19:30Z",
        avatarData: Data(), 
        contributors: [Contributor(login: "Saen Allen", avatarUrl: "", contributions: 32, avatarData: Data()),
                       Contributor(login: "Mohammad Blur", avatarUrl: "", contributions: 34, avatarData: Data()),
                       Contributor(login: "Micheal Jordan", avatarUrl: "", contributions: 6, avatarData: Data()),
                       Contributor(login: "Hamid", avatarUrl: "", contributions: 34, avatarData: Data())]
    )
    
    static let repoTow = Repository(
        name: "Repository Tow",
        owner: Owner(
            avatarUrl: ""
        ),
        hasIssues: false,
        forks: 122,
        watchers: 34,
        openIssues: 43,
        pushedAt: "2024-05-09T18:19:30Z",
        avatarData: Data(),
        contributors: []
    )
}
