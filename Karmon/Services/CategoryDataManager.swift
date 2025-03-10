//
//  CategoryDataManager.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 10/03/25.
//

import Foundation
import SwiftData

enum CategoryDeletionError: Error, LocalizedError {
    case cannotDeleteDefaultCategory

    var errorDescription: String? {
        switch self {
        case .cannotDeleteDefaultCategory:
            return "Cannot delete the default category."
        }
    }
}

final class CategoryDataManager {
    
    static let shared = CategoryDataManager()
    
    // The default category title used across the app
    private let defaultCategoryTitle = Constants.otherCategoryName
    
    // MARK: - Delete Category with Reassignment Logic
    func delete(category: Category, in context: ModelContext) throws {
        // Prevent deletion of the default "other" category.
        if category.title == defaultCategoryTitle {
            throw CategoryDeletionError.cannotDeleteDefaultCategory
        }
        
        // Fetch the default category (case-insensitive check).
        let fetchDescriptor = FetchDescriptor<Category>(/*predicate: #Predicate { $0.title == Constants.otherCategoryName }*/)
        let defaultCategory: Category
        if let fetchedDefault = try context.fetch(fetchDescriptor).first(where: { category in
            category.title == Constants.otherCategoryName
        }) {
            defaultCategory = fetchedDefault
        } else {
            // If the default category doesn't exist, create and insert it.
            defaultCategory = Category(title: defaultCategoryTitle)
            context.insert(defaultCategory)
        }
        
        // Reassign all transactions linked to the category to be deleted.
        for transaction in category.transactions {
            transaction.category = defaultCategory
        }
        
        // Now delete the category.
        context.delete(category)
        
        // Save changes.
        try context.save()
    }
}
