//
//  AddTransactionIntent.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 10/12/24.
//

import Foundation
import AppIntents
import SwiftUI

struct AddTransactionIntent: AppIntent {
    
    @Environment(\.modelContext) var context
    
    static var title = LocalizedStringResource("Add a new transaction")
    
    @Parameter(title: "Transaction title")
    var transactionTitle: String
    
    func perform() async throws -> some IntentResult {
        let transaction = Transaction(title: "Banana", amount: 1, currency: "USD", timestamp: .now)
        context.insert(transaction)
        return .result()
    }
    
}
