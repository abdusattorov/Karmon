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
        let schema = Schema([Transaction.self, Category.self])
        let config = ModelConfiguration("Transactions", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
            
            let context = container.mainContext
            let descriptor = FetchDescriptor<Category>(predicate: #Predicate { $0.title == "other" })
            if try context.fetchCount(descriptor) == 0 {
                let defaultCategory = Category(title: "other")
                context.insert(defaultCategory)
                try context.save()
            }
        } catch {
            fatalError("Could not configure the container.")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
