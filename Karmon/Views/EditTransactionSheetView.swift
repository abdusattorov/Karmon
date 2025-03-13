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
    @State private var amountText: String = ""
    @State private var currency: String = getDefaultCurrency()
    @State private var selectedCategory: Category?
    @Query private var categories: [Category]
    @FocusState private var amountFocus: Bool
    @FocusState private var titleFocus: Bool
    
    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Amount", value: $amount, format: .currency(code: currency))
                    .keyboardType(.decimalPad)
                    .focused($amountFocus)
                    .onChange(of: amountText) {
                        // Allow only digits and a decimal separator (adjust if your locale uses comma)
                        let allowedCharacters = "0123456789.,"
                        let filtered = amountText.filter { allowedCharacters.contains($0) }
                        if filtered != amountText {
                            amountText = filtered
                        }
                        
                        // Enforce the character limit
                        if amountText.count > 10 {
                            amountText = String(amountText.prefix(10))
                        }
                        
                        // Convert the text to a Double.
                        // Replace comma with dot if needed for conversion.
                        let normalizedText = amountText.replacingOccurrences(of: ",", with: ".")
                        if let value = Double(normalizedText) {
                            amount = value
                        } else {
                            amount = 0
                        }
                    }
                    .toolbar {
                        if amountFocus == true {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Next") {
                                    amountFocus = false
                                    titleFocus = true
                                }
                            }
                        }
                    }
                TextField("Title", text: $title)
                    .focused($titleFocus)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                    .overlay(
                        title.isEmpty || !titleFocus || title.count == 32 ? nil :
                        HStack {
                            Spacer()
                            Text("\(32 - title.count)")
                                .foregroundColor(.secondary)
                                .padding(.trailing, 30)
                        }
                    )
                    .onChange(of: title) {
                        if title.count > 32 {
                            title = String(title.prefix(32))
                        }
                    }
                    
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories) { category in
                        Text("\(category.title)").tag(category)
                    }
                }
                DatePicker("Date", selection: $date, in: ...Date.now, displayedComponents: .date)
            }
            .onAppear {
                currency = getDefaultCurrency() // Set default currency when the view appears
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
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedTitle.isEmpty else { return }
                        let newTransaction = Transaction(
                            id: transaction.id,
                            title: trimmedTitle,
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
                    .disabled(title.isEmpty || amount.isLessThanOrEqualTo(0))
                }
            }
            .onAppear {
                title = transaction.title
                amount = transaction.amount
                currency = transaction.currency
                selectedCategory = transaction.category
                date = transaction.dateCreated
                amountFocus = true
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
