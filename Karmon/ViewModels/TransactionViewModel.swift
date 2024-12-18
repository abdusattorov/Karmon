//
//  TransactionViewModel.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 12/12/24.
//

import Foundation

@Observable
class TransactionViewModel {
    
    static let shared = TransactionViewModel()
    
    private init() { }
    
    var transactions = [
        Transaction(title: "Coffee", amount: 2.5, currency: "EUR", category: TransactionCategory.eatingOut, timestamp: Date.fromString("12-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Groceries", amount: 45.99, currency: "EUR", category: TransactionCategory.groceries, timestamp: Date.fromString("12-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Book", amount: 12.49, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("13-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Movie Ticket", amount: 8.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("13-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Gasoline", amount: 55.30, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("14-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Concert Ticket", amount: 35.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("14-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Lunch", amount: 15.75, currency: "EUR", category: TransactionCategory.eatingOut, timestamp: Date.fromString("15-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Taxi Ride", amount: 22.0, currency: "EUR", category: TransactionCategory.transport, timestamp: Date.fromString("15-12-2024", format: "dd-mm-yyyy") ?? .now),
        Transaction(title: "Electronics", amount: 120.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("08-10-2024", format: "dd-mm-yyyy") ?? .now),
    ]
    
    // Function to group transactions by date
    func groupedTransactions() -> [String: [Transaction]] {
        let grouped = Dictionary(grouping: transactions) { (transaction: Transaction) -> String in
            // Format the timestamp to a string representing the date (ignore time)
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd MMMM yyyy"
            return formatter.string(from: transaction.timestamp)
        }
        
        // Return the grouped transactions sorted by date
        return grouped.sorted { $0.key > $1.key }
            .reduce(into: [String: [Transaction]]()) { result, group in
                result[group.key] = group.value
            }
    }
    
    func create(transaction: Transaction) {
        self.transactions.insert(transaction, at: 0)
    }
    
//    func delete(transaction: Transaction) {
//        if let index = transactions.firstIndex(where: { transaction.id == $0.id }) {
//            self.transactions.remove(at: index)
//        }
//    }
    
    func delete(at indexSet: IndexSet) {
        self.transactions.remove(atOffsets: indexSet)
    }
    
}
