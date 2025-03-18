//
//  AddRecurringView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 17/03/25.
//

import SwiftUI
import SwiftData

struct AddRecurringView: View {
    let transaction: Transaction
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var isRecurring: Bool = true
    @State private var numberRange = Array(1...366)
    @State private var interval: Int = 1
    @State private var selectedRecurranceType = RecurranceType.monthly
    @State private var recurranceDate: Date = .now
    @State private var sendNotification: Bool = false
    @FocusState private var intervalFocus: Bool
    @State private var showAlert = false
    
    // Computed property to calculate the next payment date
    var nextPaymentDate: Date {
        let now = Date.now
        var nextDate = recurranceDate
        let calendar = Calendar.current
        let component: Calendar.Component
        switch selectedRecurranceType {
        case .daily:
            component = .day
        case .weekly:
            component = .weekOfYear
        case .monthly:
            component = .month
        case .yearly:
            component = .year
        }
        if interval > 0 {
            while nextDate <= now {
                guard let newDate = calendar.date(byAdding: component, value: interval, to: nextDate) else {
                    break
                }
                nextDate = newDate
            }
        } else {
            // Handle the case where interval is zero
            nextDate = now
        }
        return nextDate
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(
                    header: Text(
                        (interval > 1) ?
                        "Every \(interval) \(selectedRecurranceType.descr)s" :
                        "Every \(selectedRecurranceType.descr)"
                    )
                        .foregroundStyle(.primary),
                    footer: HStack {
                        Text("NEXT PAYMENT: \(nextPaymentDate.toSectionHeaderFormat())")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
                    }
                ) {
                    Picker("Repeat", selection: $selectedRecurranceType) {
                        ForEach(RecurranceType.allCases) { type in
                            Text(type.descr).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Text("Repeat every")
                        TextField("\(selectedRecurranceType.descr)", value: $interval, format: .number)
                            .keyboardType(.numberPad)
                            .focused($intervalFocus)
                            .multilineTextAlignment(.trailing)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                            }
                            .onChange(of: interval) {
                                // Validate and update interval
                                if interval > 0 {
                                    return
                                } else {
                                    showAlert = true
                                    interval = 1
                                }
                            }
                    }
                    
                    DatePicker("Start", selection: $recurranceDate)
                }
                
                Section(
                    footer: HStack {
                        Text("The day before payment")
                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
                    }
                ) {
                    Toggle(isOn: $sendNotification) {
                        Text("Send Notification")
                    }
                }
                
                if transaction.isRecurring {
                    Button(role: .destructive) {
                        let updatedTransaction = Transaction(
                            id: transaction.id,
                            title: transaction.title,
                            amount: transaction.amount,
                            currency: transaction.currency,
                            dateCreated: transaction.dateCreated,
                            category: transaction.category,
                            isRecurring: false,
                            recurranceType: nil,
                            recurranceInterval: nil,
                            recurranceDate: nil
                        )
                        
                        context.insert(updatedTransaction)
                        
//                        transaction.isRecurring = false
//                        transaction.recurranceType = nil
//                        transaction.recurranceInterval = nil
//                        transaction.recurranceDate = nil

                        do {
                            try context.save()
                        } catch {
                            print("Failed to save.")
                        }
                        
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Remove Recurring")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Add To Recurring")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let updatedTransaction = Transaction(
                            id: transaction.id,
                            title: transaction.title,
                            amount: transaction.amount,
                            currency: transaction.currency,
                            dateCreated: transaction.dateCreated,
                            category: transaction.category,
                            isRecurring: true,
                            recurranceType: selectedRecurranceType,
                            recurranceInterval: interval,
                            recurranceDate: nextPaymentDate
                        )
                        
                        context.insert(updatedTransaction)
                        
//                        transaction.isRecurring = true
//                        transaction.recurranceType = selectedRecurranceType
//                        transaction.recurranceInterval = interval
//                        transaction.recurranceDate = nextPaymentDate
                        
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
                if transaction.isRecurring {
                    selectedRecurranceType = transaction.recurranceType!
                    interval = transaction.recurranceInterval!
                }
                intervalFocus = true
            }
            .alert("Invalid Interval", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Interval must be greater than 0.")
            }
        }
    }
}

#Preview {
    AddRecurringView(
        transaction: Transaction(
            id: UUID(),
            title: "Something",
            amount: 3,
            currency: "USD",
            dateCreated: Date.now,
            category: Category(title: "Other"),
            isRecurring: true,
            recurranceType: RecurranceType.weekly,
            recurranceInterval: 1,
            recurranceDate: Date.now
        )
    )
}
