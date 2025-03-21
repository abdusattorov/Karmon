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
                .preferredColorScheme(.dark)
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Transaction.self, Category.self])
        let config = ModelConfiguration("Transactions", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
            
            //            add the 'other' category when the app is launched for the first time
            let name = Constants.otherCategoryName
            let context = container.mainContext
            let descriptor = FetchDescriptor<Category>(predicate: #Predicate { $0.title == name })
            if try context.fetchCount(descriptor) == 0 {
                let defaultCategory = Category(title: Constants.otherCategoryName)
                context.insert(defaultCategory)
                try context.save()
            }
            
        } catch {
            fatalError("Could not configure the container.")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
