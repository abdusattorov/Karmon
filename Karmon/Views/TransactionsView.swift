//
//  TransactionsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    
    var transactionVM: TransactionViewModel = TransactionViewModel.shared
    
    @Environment(\.modelContext) var context
    @State private var isShowingAddTransactionSheet = false
//    @Query(sort: \Transaction.timestamp) var transactions: [Transaction] = []
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(transactionVM.transactions) { transaction in
                    TransactionCellView(transaction: transaction)
                }
//                .onDelete { indexSet in
//                    for index in indexSet {
//                        context.delete(transactions[index])
//                    }
//                }
                .onDelete { indexSet in
                    transactionVM.delete(at: indexSet)
                }
            }
            .navigationTitle("Transactions")
            .sheet(isPresented: $isShowingAddTransactionSheet) {
                AddTransactionSheetView(isShowingAddTransactionSheet: $isShowingAddTransactionSheet)
            }
            .toolbar {
                if !transactionVM.transactions.isEmpty {
                    Button("Add Transaction", systemImage: "plus") {
                        isShowingAddTransactionSheet.toggle()
                    }
                }
            }
            .overlay {
                if transactionVM.transactions.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Transactions", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding transactions to see your list")
                    }, actions: {
                        Button("Add Transaction") {
                            isShowingAddTransactionSheet.toggle()
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
