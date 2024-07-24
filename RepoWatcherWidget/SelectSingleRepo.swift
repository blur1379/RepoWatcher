//
//  SelectSingleRepo.swift
//  RepoWatcher
//
//  Created by Mohammad Blur on 7/24/24.
//

import Foundation
import AppIntents


struct SelectSingleRepo: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "SelectSingleRepoIntent"

    static var title: LocalizedStringResource = "Select Single Repo"
    static var description = IntentDescription("Choose a repository to watch")

    @Parameter(title: "repo", optionsProvider: RepoOptionsProvider())
    var repo: String?

    struct RepoOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
                throw UserDefaultsError.retrieval
            }
            return repos
        }
        
        func defaultResult() async -> String? { "blur1379/RepoWatcher" }
    }

}


