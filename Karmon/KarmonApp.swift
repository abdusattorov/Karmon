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
    
//    let container: ModelContainer = {
//        let schema = Schema()
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
//    let container: ModelContainer? = {
//        do {
//            let schema = Schema()
//            let container = try ModelContainer(for: schema, configurations: [])
//            return container
//        } catch {
//            print("Error initializing ModelContainer: \(error)")
//            return nil
//        }
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
