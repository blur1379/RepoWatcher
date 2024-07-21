//
//  IntentHandler.swift
//  RepoWatcherIntents
//
//  Created by Mohammad Blur on 7/21/24.
//

import Intents


class IntentHandler: INExtension{
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
}

extension IntentHandler: SelectSingleRepoIntentHandling {
    func provideRepoOptionsCollection(for intent: SelectSingleRepoIntent) async throws -> INObjectCollection<NSString> {
        guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) else {
            throw UserDefaultsError.retrieval
        }
    }
}
