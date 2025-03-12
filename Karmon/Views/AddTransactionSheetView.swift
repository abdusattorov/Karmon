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
                TextField("Title", text: $title)
                    .focused($titleFocus)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
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
