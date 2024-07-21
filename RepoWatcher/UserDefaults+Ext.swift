//
//  UserDefaults+Ext.swift
//  RepoWatcher
//
//  Created by Mohammad Blur on 7/19/24.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.co.blur.RepoWatcher")!
    }
    
    static var repoKey = "repos"
}

enum UserDefaultsError: Error {
    case retrieval
}
