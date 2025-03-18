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
    @State private var lastAmount: Double = 0
    @State private var maxAmount: Double = 10_000_000_000
    
    @State private var selectedCurrency: String = ""
    @State private var currencies: [String] = getAllCurrencies()
    
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
                Section {
                    HStack {
                        Menu {
                            Picker("", selection: $selectedCurrency) {
                                ForEach(currencies, id: \.self) { currency in
                                    Text(currency)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedCurrency)
                                    .font(.footnote)
                            }
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.tertiarySystemFill)))
                        }
                        
                        TextField("Amount", value: $amount, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountFocus)
                            .onChange(of: amount) {
                                if amount < maxAmount {
                                    lastAmount = amount
                                } else {
                                    amount = lastAmount
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
                    }
                    HStack {
                        Image(systemName: "text.word.spacing")
                            .padding(.horizontal, 11)
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
                    }
                        
                    HStack {
                        Image(systemName: "folder")
                            .padding(.horizontal, 11)
                        Text("Category")
                        Menu {
                            Picker("", selection: $selectedCategory) {
                                ForEach(categories) { category in
                                    Text("\(category.title)").tag(category)
                                }
                            }
                        } label: {
                            Spacer()
                            HStack {
                                Text(selectedCategory?.title ?? "Other")
                                    .font(.subheadline)
                            }
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.tertiarySystemFill)))
                        }
                    }
                    HStack {
                        Image(systemName: "calendar")
                            .padding(.horizontal, 11)
                        DatePicker("Date", selection: $date, in: ...Date.now, displayedComponents: .date)
                    }
                }

            }
            .onAppear {
                selectedCurrency = transaction.currency
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
                            currency: selectedCurrency,
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
                selectedCurrency = transaction.currency
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
            id: UUID(),
            title: "Something",
            amount: 3,
            currency: "USD",
            dateCreated: Date.now,
            category: Category(title: "Other"),
            isRecurring: true,
            recurranceType: RecurranceType.monthly,
            recurranceInterval: 1,
            recurranceDate: Date.now
        )
    )
}
