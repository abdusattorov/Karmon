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
    @State private var addTransaction = false
//    @State private var editTransaction = false
    @State private var selectedTransaction: Transaction?
    @Query private var transactions: [Transaction]
    @Query private var categories: [Category]

    private var groupedTransactions: [(key: Date, value: [Transaction])] {
        let groupedDict = Dictionary(grouping: transactions) { transaction in
            // Remove time components from the date
            Calendar.current.startOfDay(for: transaction.dateCreated)
        }
        
        // Sort by date descending
        return groupedDict.sorted { $0.key > $1.key }
    }
    
    // Cached formatter for currency formatting
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(groupedTransactions, id: \.key) { date, transactionsForDate in
                    Section(
                        header: Text(date.toSectionHeaderFormat())
                            .foregroundStyle(.primary),
                        footer: HStack {
                            Spacer()
                            Text("Total: \(totalAmountString(for: transactionsForDate))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    ) {
                        ForEach(transactionsForDate) { transaction in
//                            Button {
//                                selectedTransaction = transaction
//                                editTransaction.toggle()
//                            } label: {
//                                TransactionCellView(transaction: transaction)
//                                    .contentShape(Rectangle())
//                            }
//                            .buttonStyle(.plain)
                            TransactionCellView(transaction: transaction)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedTransaction = transaction
//                                    editTransaction.toggle()
                                }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let transaction = transactionsForDate[index]
                                context.delete(transaction)
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            .navigationTitle("Transactions")
            .sheet(isPresented: $addTransaction) {
                AddTransactionSheetView()
            }
            .sheet(item: $selectedTransaction) { transaction in
                EditTransactionSheetView(transaction: transaction)
            }
            
            .toolbar {
                if !transactions.isEmpty {
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
    
    private func totalAmountString(for transactions: [Transaction]) -> String {
        let total = transactions.reduce(0) { $0 + $1.amount }
        
        // Get the currency of the first transaction (assuming all transactions on a given day have the same currency)
        let currencyCode = transactions.first?.currency ?? "USD" // Default to "USD" if no currency is found
        
        // Create a new formatter for each currency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode // Use the currency of the first transaction
        
        return formatter.string(from: NSNumber(value: total)) ?? "$0.00"
    }

}

#Preview {
    let preview = Preview(Transaction.self)
    let category = Category.categorySamples
    let transactions = Transaction.transactionSamples
    
    preview.addExamples(category)
    preview.addExamples(transactions)
    
    return TransactionsView()
        .modelContainer(preview.container)
}
