//
//  PreviewContainer.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 08/03/25.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let scheme = Schema(models)
        do {
            container = try ModelContainer(for: scheme, configurations: config)
        } catch {
            fatalError("Could not configure the container.")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
