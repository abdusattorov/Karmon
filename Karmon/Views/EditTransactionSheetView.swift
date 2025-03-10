//
//  EditTransactionSheetView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 06/03/25.
//

import SwiftUI
import SwiftData

struct EditTransactionSheetView: View {
    
    let transaction: Transaction
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var title: String = ""
    @State private var date: Date = .now
    @State private var amount: Double = 0
    @State private var currency: String = "USD"
    @State private var selectedCategory: Category?
    @Query private var categories: [Category]
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories) { category in
                        Text("\(category.title)").tag(category)
                    }
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Amount", value: $amount, format: .currency(code: "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Edit Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        guard let selectedCategory else {
                            return
                        }
                        let newTransaction = Transaction(
                            id: transaction.id,
                            title: title,
                            amount: amount,
                            currency: currency,
                            dateCreated: date,
                            category: selectedCategory
                        )
                        context.insert(newTransaction)
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save.")
                        }
                        dismiss()
                    }
                }
            }
            .onAppear {
                title = transaction.title
                amount = transaction.amount
                currency = transaction.currency
                selectedCategory = transaction.category
                date = transaction.dateCreated
            }
        }
        
    }
}

#Preview {
    
    EditTransactionSheetView(
        transaction: Transaction(
            title: "Lemon tea",
            amount: 0.8,
            currency: "EUR",
            dateCreated: .now,
            category: Category(title: "other")
        )
    )
}
