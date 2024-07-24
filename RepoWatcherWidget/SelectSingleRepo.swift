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

    @Parameter(title: "repo", optionsProvider: StringOptionsProvider())
    var repo: String?

    struct StringOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            // TODO: Return possible options here.
            return []
        }
    }

}


