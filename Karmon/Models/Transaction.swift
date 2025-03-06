//
//  Transaction.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import Foundation
import SwiftData
import AppIntents


//struct Transaction: Identifiable {
//    var id: UUID = UUID()
//    var title: String
//    var amount: Double
//    var currency: String
//    var category: TransactionCategory
//    var timestamp: Date
//}

//enum TransactionCategory: String, AppEnum, CaseIterable {
//    case groceries = "Groceries"
//    case eatingOut = "Eating Out"
//    case snacks = "Snacks"
//    case rent = "Rent"
//    case transport = "Transport"
//    case clothes = "Clothes"
//    case traveling = "Traveling"
//    case other = "Other"
//    
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Category"
//    
//    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
//        .groceries: "Groceries",
//        .eatingOut: "Eating Out",
//        .snacks: "Snacks",
//        .rent: "Rent",
//        .transport: "Transport",
//        .clothes: "Clothes",
//        .traveling: "Traveling",
//        .other: "Other"
//    ]
//
//}

@Model
class Transaction {
    var title: String = ""
    var amount: Double = 0
    var currency: String = ""
    var dateCreated: Date = Date.now
    
    init(
        title: String,
        amount: Double,
        currency: String,
        dateCreated: Date
    ) {
        self.title = title
        self.amount = amount
        self.currency = currency
        self.dateCreated = dateCreated
    }
    
    var category: Category?
}

@Model
class Category {
    var title: String = ""
    var transactions: [Transaction]?
    
    init(title: String) {
        self.title = title
    }
}

//extension Transaction: AppEntity {
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Expense"
//    var displayRepresentation: DisplayRepresentation {
//        .init(title: LocalizedStringResource(stringLiteral: title))
//    }
//    
//    static var defaultQuery = TransactionQuery()
//}
//
//struct TransactionQuery: EntityQuery {
//    
//    func entities(for identifiers: [UUID]) async throws -> [Transaction] {
//        TransactionViewModel.shared.transactions.filter { identifiers.contains($0.id) }
//    }
//    
//}

//extension MovieRating: AppEnum {
//    // 2.
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Film Rating"
//    
//    // 3.
//    static var caseDisplayRepresentations: [MovieRating: DisplayRepresentation] = [
//        .toWatch: "To watch",
//        .bad: "Bad",
//        .good: "Good",
//        .incredible: "Incredible 💫",
//    ]
//}
