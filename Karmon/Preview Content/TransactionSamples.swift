//
//  TransactionSamples.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 08/03/25.
//

import Foundation

extension Transaction {
    
    static var transactionSamples: [Transaction] {
        
        // Get all available categories
        let categories = Category.categorySamples
        
        // Create an array of transactions using the existing categories
        return [
            // Groceries
            Transaction(
                title: "Meat",
                amount: 100.50,
                currency: "USD",
                dateCreated: Date.fromString("2024-02-25", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Groceries" } ?? Category(title: "Groceries") // Default fallback category
            ),
            Transaction(
                title: "Vegetables",
                amount: 35.20,
                currency: "USD",
                dateCreated: Date.fromString("2024-02-25", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Groceries" } ?? Category(title: "Groceries")
            ),
            Transaction(
                title: "Milk and Cheese",
                amount: 24.75,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-01", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Groceries" } ?? Category(title: "Groceries")
            ),
            Transaction(
                title: "Bread and Eggs",
                amount: 12.80,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-01", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Groceries" } ?? Category(title: "Groceries")
            ),
            Transaction(
                title: "Fruits",
                amount: 28.90,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-03", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Groceries" } ?? Category(title: "Groceries")
            ),
            
            // Others
            Transaction(
                title: "Electricity Bill",
                amount: 120.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-02", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Other" } ?? Category(title: "Other")
            ),
            Transaction(
                title: "Internet Subscription",
                amount: 55.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-02", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Other" } ?? Category(title: "Other")
            ),
            Transaction(
                title: "Mobile Plan",
                amount: 30.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-05", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Other" } ?? Category(title: "Other")
            ),
            Transaction(
                title: "Water Bill",
                amount: 40.25,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-05", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Other" } ?? Category(title: "Other")
            ),
            Transaction(
                title: "Garbage Collection Fee",
                amount: 22.50,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-07", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Other" } ?? Category(title: "Other")
            ),
            
            // Snacks
            Transaction(
                title: "Cupcake",
                amount: 5.50,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-01", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Snacks" } ?? Category(title: "Snacks")
            ),
            Transaction(
                title: "Bag of Chips",
                amount: 3.25,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-03", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Snacks" } ?? Category(title: "Snacks")
            ),
            Transaction(
                title: "Chocolate Bar",
                amount: 2.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-05", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Snacks" } ?? Category(title: "Snacks")
            ),
            Transaction(
                title: "Ice Cream Cone",
                amount: 4.75,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-06", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Snacks" } ?? Category(title: "Snacks")
            ),
            Transaction(
                title: "Smoothie",
                amount: 6.90,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-06", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Snacks" } ?? Category(title: "Snacks")
            ),
            
            // Going out
            Transaction(
                title: "Dinner at Restaurant",
                amount: 45.75,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-07", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Movie Tickets",
                amount: 30.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-08", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Bowling Night",
                amount: 25.50,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-08", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Concert Ticket",
                amount: 75.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-09", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Coffee with Friends",
                amount: 15.20,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-09", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Weekend Trip",
                amount: 120.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-09", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            ),
            Transaction(
                title: "Lunch at Park",
                amount: 35.00,
                currency: "USD",
                dateCreated: Date.fromString("2024-03-09", format: "yyyy-MM-dd") ?? .now,
                category: categories.first { $0.title == "Going out" } ?? Category(title: "Going out")
            )
        ]
    }
}
