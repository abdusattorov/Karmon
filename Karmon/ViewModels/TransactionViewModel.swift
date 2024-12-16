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
        Transaction(title: "Coffee", amount: 2.5, currency: "EUR", timestamp: .now),
        Transaction(title: "Groceries", amount: 45.99, currency: "EUR", timestamp: .now),
        Transaction(title: "Book", amount: 12.49, currency: "EUR", timestamp: .now),
        Transaction(title: "Movie Ticket", amount: 8.0, currency: "EUR", timestamp: .now),
        Transaction(title: "Gasoline", amount: 55.30, currency: "EUR", timestamp: .now),
        Transaction(title: "Concert Ticket", amount: 35.0, currency: "EUR", timestamp: .now),
        Transaction(title: "Lunch", amount: 15.75, currency: "EUR", timestamp: .now),
        Transaction(title: "Taxi Ride", amount: 22.0, currency: "EUR", timestamp: .now),
        Transaction(title: "Electronics", amount: 120.0, currency: "EUR", timestamp: .now),
    ]
    
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
