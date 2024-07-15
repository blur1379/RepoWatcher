//
//  RepoWatcherWidgetBundle.swift
//  RepoWatcherWidget
//
//  Created by Mohammad Blur on 7/7/24.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
