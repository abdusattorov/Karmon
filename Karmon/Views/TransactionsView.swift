//
//  TransactionsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    
//    var transactionVM: TransactionViewModel = TransactionViewModel.shared
    
    @Environment(\.modelContext) var context
    @State private var addTransaction = false
    @Query private var transactions: [Transaction]
    @Query private var categories: [Category]
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(transactions) { transaction in
                    VStack {
                        Text(transaction.title)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let transaction = transactions[index]
                        context.delete(transaction)
                    }
                }
            }
            .listStyle(.inset)
            
            .navigationTitle("Transactions")
            .sheet(isPresented: $addTransaction) {
                AddTransactionSheetView()
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
}

#Preview {
    TransactionsView()
}
