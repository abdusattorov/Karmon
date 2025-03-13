//
//  TransactionsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    
    @Environment(\.modelContext) var context
    @Query private var transactions: [Transaction]
    @Query private var categories: [Category]
//    @State private var selectedTransaction: Transaction?
    @State private var addTransaction = false
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "All"
    
    // Cached formatter for currency formatting
//    private static let currencyFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 2
//        return formatter
//    }()
    
    var body: some View {
        
        NavigationStack {
            
            TransactionListView(filterBy: selectedCategory, searchString: searchText)
            
                .searchable(text: $searchText)
                .navigationTitle("Transactions")
                .sheet(isPresented: $addTransaction) {
                    AddTransactionSheetView()
                }
            
                .toolbar {
                    if !transactions.isEmpty {
                        
                        Menu {
                            Picker("Category", selection: $selectedCategory) {
                                Text("All").tag("All")
                                ForEach(categories) { category in
                                    Text("\(category.title)").tag(category.title)
                                }
                            }
                        } label: {
                            Image(
                                systemName: selectedCategory == "All" || selectedCategory == "" ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill"
                            )
                        }
                        
                        Button("Add Transaction", systemImage: "plus") {
                            addTransaction.toggle()
                        }
                        
                    }
                }
            
                .overlay {
                    if transactions.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Transactions", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding transactions to see your list")
                        }, actions: {
                            Button("Add Transaction") {
                                addTransaction.toggle()
                            }
                        })
                        .offset(y: -60)
                    }
                }
        }
    }
}

#Preview {
    let preview = Preview(Transaction.self)
    let categories = Category.categorySamples
    let transactions = Transaction.transactionSamples
    
    preview.addExamples(categories)
    preview.addExamples(transactions)
    
    return TransactionsView()
        .modelContainer(preview.container)
}
