//
//  Repository.swift
//  RepoWatcher
//
//  Created by Mohammad Blur on 7/9/24.
//

import Foundation

struct Repository: Decodable {
    let neme: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
}

struct Owner: Decodable {
    let avatarUrl: String
}
