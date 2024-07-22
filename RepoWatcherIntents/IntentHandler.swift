//
//  IntentHandler.swift
//  RepoWatcherIntents
//
//  Created by Mohammad Blur on 7/21/24.
//

import Intents


class IntentHandler: INExtension{
    
    override func handler(for intent: INIntent) -> Any {        
        return self
    }
}

extension IntentHandler: SelectSingleRepoIntentHandling {
    func provideRepoOptionsCollection(for intent: SelectSingleRepoIntent) async throws -> INObjectCollection<NSString> {
        guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
            throw UserDefaultsError.retrieval
        }
        return INObjectCollection(items: repos as [NSString])
    }
    
    func defaultRepo(for intent: SelectSingleRepoIntent) -> String? {
        return "blur1379/RepoWatcher"
    }
}
