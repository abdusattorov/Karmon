//
//  TransactionListView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 13/03/25.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    
    @Environment(\.modelContext) var context
    @Query private var transactions: [Transaction]
    @Query private var categories: [Category]
    @State private var selectedTransaction: Transaction?
    

    private var groupedTransactions: [(key: Date, value: [Transaction])] {
        let groupedDict = Dictionary(grouping: transactions) { transaction in
            Calendar.current.startOfDay(for: transaction.dateCreated)
        }
        
        // Sort by date descending
        return groupedDict.sorted { $0.key > $1.key }
    }
    
    var body: some View {
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
                        TransactionCellView(transaction: transaction)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedTransaction = transaction
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
            
            .sheet(item: $selectedTransaction) { transaction in
                EditTransactionSheetView(transaction: transaction)
            }
            
        }
        .scrollIndicators(.hidden)
    }
    
    init(filterBy: String, searchString: String) {
        
        var predicate: Predicate<Transaction>
        
        if searchString.isEmpty {
            if filterBy.isEmpty {
                if filterBy == "All" {
                    predicate = #Predicate { transaction in
                        true
                    }
                } else {
                    predicate = #Predicate{ transaction in
                        transaction.category.title.localizedStandardContains(filterBy)
                    }
                }
            } else {
                predicate = #Predicate { transaction in
                    true
                }
            }
        } else {
            predicate = #Predicate { transaction in
                transaction.title.localizedStandardContains(searchString)
            }
        }
        
        _transactions = Query(filter: predicate)
    }
    
    private func totalAmountString(for transactions: [Transaction]) -> String {
        // Calculate the total amount for each currency
        let currencyTotals = Dictionary(grouping: transactions, by: { $0.currency })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        // Format each total amount
        let formattedTotals = currencyTotals.compactMap { currency, total -> String? in
            formatter.currencyCode = currency
            return formatter.string(from: NSNumber(value: total))
        }
        
        return formattedTotals.joined(separator: "; ")
    }
}

#Preview {
    let preview = Preview(Transaction.self)
    let category = Category.categorySamples
    let transactions = Transaction.transactionSamples
    
    
    preview.addExamples(category)
    preview.addExamples(transactions)
    
    return TransactionListView(filterBy: "Other", searchString: "")
        .modelContainer(preview.container)
}
