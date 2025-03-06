//
//  KarmonApp.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI
import SwiftData

@main
struct KarmonApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Transaction.self])
        let config = ModelConfiguration("Transactions", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container.")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
