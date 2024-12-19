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
        // October Transactions
        Transaction(title: "Laptop Repair", amount: 85.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("01-10-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Coffee", amount: 10.99, currency: "EUR", category: TransactionCategory.snacks, timestamp: Date.fromString("01-10-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Groceries", amount: 30.5, currency: "EUR", category: TransactionCategory.groceries, timestamp: Date.fromString("15-10-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Dinner", amount: 60.75, currency: "EUR", category: TransactionCategory.eatingOut, timestamp: Date.fromString("15-10-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Gym Membership", amount: 40.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("20-10-2024", format: "dd-MM-yyyy") ?? .now),
        
        // November Transactions
        Transaction(title: "Online Course", amount: 50.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("05-11-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Ticket", amount: 25.0, currency: "EUR", category: TransactionCategory.transport, timestamp: Date.fromString("05-11-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Jacket", amount: 120.0, currency: "EUR", category: TransactionCategory.clothes, timestamp: Date.fromString("15-11-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Groceries", amount: 35.99, currency: "EUR", category: TransactionCategory.groceries, timestamp: Date.fromString("15-11-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Snacks", amount: 12.5, currency: "EUR", category: TransactionCategory.snacks, timestamp: Date.fromString("20-11-2024", format: "dd-MM-yyyy") ?? .now),
        
        // December Transactions
        Transaction(title: "Gift", amount: 200.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("10-12-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Netflix", amount: 16.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("10-12-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Groceries", amount: 50.5, currency: "EUR", category: TransactionCategory.groceries, timestamp: Date.fromString("15-12-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Taxi Ride", amount: 18.0, currency: "EUR", category: TransactionCategory.transport, timestamp: Date.fromString("15-12-2024", format: "dd-MM-yyyy") ?? .now),
        Transaction(title: "Concert", amount: 75.0, currency: "EUR", category: TransactionCategory.other, timestamp: Date.fromString("25-12-2024", format: "dd-MM-yyyy") ?? .now),
    ]
    
    // Function to group transactions by date
    func groupedTransactions() -> [String: [Transaction]] {
        let grouped = Dictionary(grouping: transactions) { (transaction: Transaction) -> String in
            // Format the timestamp to a string representing the date (ignore time)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy" // Format for month and year
            return formatter.string(from: transaction.timestamp)
        }
        
        // Sort groups by actual Date (ascending or descending)
            return grouped.sorted {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM yyyy"
                let date1 = formatter.date(from: $0.key) ?? Date()
                let date2 = formatter.date(from: $1.key) ?? Date()
                return date1 > date2 // Change to `<` for ascending
            }
            .reduce(into: [String: [Transaction]]()) { result, group in
                result[group.key] = group.value
            }
    }
    
//    func groupedTransactionsByMonthAndDate() -> [String: [String: [Transaction]]] {
//        // First, group by month and year
//        let groupedByMonth = Dictionary(grouping: transactions) { (transaction: Transaction) -> String in
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MMMM yyyy" // Format for month and year
//            return formatter.string(from: transaction.timestamp)
//        }
//        
//        // For each month, group further by exact date
//        let groupedByMonthAndDate = groupedByMonth.mapValues { transactionsInMonth -> [String: [Transaction]] in
//            Dictionary(grouping: transactionsInMonth) { (transaction: Transaction) -> String in
//                let formatter = DateFormatter()
//                formatter.dateFormat = "EEEE, dd MMMM yyyy" // Format for full date
//                return formatter.string(from: transaction.timestamp)
//            }
//        }
//        
//        // Sort the months and dates
//        let sortedByMonthAndDate = groupedByMonthAndDate.sorted {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MMMM yyyy"
//            let date1 = formatter.date(from: $0.key) ?? Date()
//            let date2 = formatter.date(from: $1.key) ?? Date()
//            return date1 > date2 // Change to `<` for ascending
//        }
//        .reduce(into: [String: [String: [Transaction]]]()) { result, group in
//            // Sort dates within each month
//            let sortedDates = group.value.sorted {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "EEEE, dd MMMM yyyy"
//                let date1 = formatter.date(from: $0.key) ?? Date()
//                let date2 = formatter.date(from: $1.key) ?? Date()
//                return date1 < date2 // Change to `>` for descending
//            }
//            .reduce(into: [String: [Transaction]]()) { result, dateGroup in
//                result[dateGroup.key] = dateGroup.value
//            }
//            
//            result[group.key] = sortedDates
//        }
//        
//        return sortedByMonthAndDate
//    }
    
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
