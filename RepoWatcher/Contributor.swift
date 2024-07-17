//
//  Contributor.swift
//  RepoWatcher
//
//  Created by Mohammad Blur on 7/16/24.
//

import Foundation

struct Contributor: Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let contributions: Int
    let avatarData: Data
}

extension Contributor {
    struct CodingData: Decodable {
        let login: String
        let avatarUrl: String
        let contributions: Int
        
        var contributors: Contributor {
            Contributor(
                login: login,
                avatarUrl: avatarUrl,
                contributions: contributions,
                avatarData: Data()
            )
        }
    }
}
