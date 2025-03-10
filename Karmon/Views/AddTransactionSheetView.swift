//
//  AddTransactionSheetVi.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI
import SwiftData

struct AddTransactionSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var title: String = ""
    @State private var date: Date = .now
    @State private var amount: Double?
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
            .navigationTitle("New Transaction")
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
                        let newTransaction = Transaction(title: title, amount: amount ?? 0, currency: currency, dateCreated: date, category: selectedCategory)
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
                if let category = categories.first(where: { $0.title == Constants.otherCategoryName }) {
                    selectedCategory = category
                }
            }
        }
        
    }
}

#Preview {
    AddTransactionSheetView()
}
