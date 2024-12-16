//
//  Transaction.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import Foundation
import SwiftData
import AppIntents


struct Category: Identifiable {
    var id: UUID = UUID()
    var title: String
}

//@Model
struct Transaction: Identifiable {
//    var id: String
    var id: UUID = UUID()
    var title: String
    var amount: Double
    var currency: String
    var timestamp: Date
    
//    init(id: String = UUID().uuidString, title: String, amount: Double, currency: String, timestamp: Date) {
//        self.id = id
//        self.title = title
//        self.amount = amount
//        self.currency = currency
//        self.timestamp = timestamp
//    }
}

extension Transaction: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Transaction"
    var displayRepresentation: DisplayRepresentation {
        .init(title: LocalizedStringResource(stringLiteral: title))
    }
    
    static var defaultQuery = TransactionQuery()
}

struct TransactionQuery: EntityQuery {
    
    func entities(for identifiers: [UUID]) async throws -> [Transaction] {
        TransactionViewModel.shared.transactions.filter { identifiers.contains($0.id) }
    }
    
}

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
