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
    @State private var lastAmount: Double = 0
    @State private var maxAmount: Double = 10_000_000_000
    
    @State private var selectedCurrency: String = getDefaultCurrency()
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
                            guard var amount else { return }
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
