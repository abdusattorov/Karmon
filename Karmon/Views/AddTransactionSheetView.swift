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
                TextField("Amount", text: $amountText)
                    .keyboardType(.decimalPad)
                    .focused($amountFocus)
                    .onChange(of: amountText) {
                            // Allow only digits and a decimal separator.
                            let allowedCharacters = "0123456789.,"
                            let filtered = amountText.filter { allowedCharacters.contains($0) }
                            if filtered != amountText {
                                amountText = filtered
                            }
                            
                            // Enforce the character limit.
                            if amountText.count > 10 {
                                amountText = String(amountText.prefix(10))
                            }
                            
                            // Convert to Double.
                            let normalizedText = amountText.replacingOccurrences(of: ",", with: ".")
                            if let value = Double(normalizedText) {
                                amount = value
                            } else {
                                amount = nil
                            }
                        }
//                        .onChange(of: amountFocus) {
//                            if !amountFocus {
//                                // When editing ends, format the value.
//                                if let value = amount {
//                                    let formatter = NumberFormatter()
//                                    formatter.numberStyle = .currency
//                                    formatter.currencyCode = currency
//                                    formatter.minimumFractionDigits = 0
//                                    formatter.maximumFractionDigits = 2
//                                    if let formatted = formatter.string(from: NSNumber(value: value)) {
//                                        amountText = formatted
//                                    }
//                                }
//                            } else {
//                                // When editing begins, revert to a plain number.
//                                if let value = amount {
//                                    amountText = String(value)
//                                }
//                            }
//                        }
                    .toolbar {
                        if amountFocus == true && (amount != nil) {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Next") {
                                    amountFocus = false
                                    titleFocus = true
                                }
                            }
                        }
                    }
//                CurrencyTextField(value: $amount, currencyCode: currency)
//                    .focused($amountFocus)
//                    .toolbar {
//                        if amountFocus && amount != nil {
//                            ToolbarItemGroup(placement: .keyboard) {
//                                Spacer()
//                                Button("Next") {
//                                    amountFocus = false
//                                    titleFocus = true
//                                }
//                            }
//                        }
//                    }
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
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedTitle.isEmpty else { return }
                        let newTransaction = Transaction(
                            title: trimmedTitle,
                            amount: amount ?? 0,
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
                    .disabled(!isTitleValid || amount == nil || amount! <= 0)
                }
            }
            .onAppear {
                if let category = categories.first(where: { $0.title == Constants.otherCategoryName }) {
                    selectedCategory = category
                }
                amountFocus = true
            }
        }
        
    }
}

#Preview {
    AddTransactionSheetView()
}
