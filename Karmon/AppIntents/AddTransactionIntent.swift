////
////  AddTransactionIntent.swift
////  Karmon
////
////  Created by Abdusamad Abdusattorov on 10/12/24.
////
//
//import Foundation
//import AppIntents
//import SwiftUI
//
//struct AddTransactionIntent: AppIntent {
//    
////    @Environment(\.modelContext) var context
//    
//    static var title = LocalizedStringResource("Add a new expense")
//    
//    @Parameter(title: "Title")
//    var transactionTitle: String
//    
//    @Parameter(title: "Cost")
//    var transactionAmount: Double
//    
//    @Parameter(title: "Category")
//    var transactionCategory: TransactionCategory
//    
//    func perform() async throws -> some IntentResult {
//        let transaction = Transaction(title: transactionTitle, amount: transactionAmount, currency: "USD", category: transactionCategory, timestamp: .now)
////        context.insert(transaction)
//        TransactionViewModel.shared.create(transaction: transaction)
//        return .result()
//    }
//    
//}
//
//
////struct GetTransactionsIntent: AppIntent {
////    static var title: LocalizedStringResource = "Get Transactions"
////    static var description: LocalizedStringResource = "Retrieve all transactions"
////
////    @Binding var modelContext: ModelContext
////
////    func perform() async throws -> some IntentResult {
////        let transactions = try modelContext.fetch(Transaction.fetchRequest())
////
////        // Return the transactions as a result
////        let transactionTitles = transactions.map { $0.title }
////        return .result(value: transactionTitles)
////    }
////}
