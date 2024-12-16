//
//  KarmonShortcutProvider.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 16/12/24.
//

import Foundation
import AppIntents


struct MovieAppShortcutProvider: AppShortcutsProvider {

    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {

        AppShortcut(
            intent: AddTransactionIntent(),
            phrases: [
                "Add a new transaction to the list"
            ],
            shortTitle: "Add Transaction",
            systemImageName: "scroll.fill"
        )
        
//        AppShortcut(
//            intent: MovieRatingIntent(),
//            phrases: [
//                "Add rating to movies"
//            ],
//            shortTitle: "Add rating",
//            systemImageName: "star.circle"
//        )
    }
}

