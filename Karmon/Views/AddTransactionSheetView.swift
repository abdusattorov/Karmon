//
//  AddTransactionSheetView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI

struct AddTransactionSheetView: View {
//    @Environment(\.modelContext) var context
    
    let transactionVM: TransactionViewModel = TransactionViewModel.shared
    
    @State private var title: String = ""
    @State private var date: Date = .now
    @State private var amount: Double = 0
    @State private var currency: String = "USD"
    @Binding var isShowingAddTransactionSheet: Bool
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isShowingAddTransactionSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        let transaction = Transaction(title: title, amount: amount, currency: currency, timestamp: date)
//                        context.insert(transaction)
                        
//                        If SwiftData auto-save doesn't work, uncomment this snippet
//                        do {
//                            try context.save()
//                            isShowingAddTransactionSheet.toggle()
//                        } catch {
//                            print("Failed to save context \(error)")
//                        }
                        transactionVM.create(transaction: transaction)
                        isShowingAddTransactionSheet.toggle()
                    }
                }
                
            }
        }
        
    }
}

#Preview {
    AddTransactionSheetView(isShowingAddTransactionSheet: .constant(true))
}
